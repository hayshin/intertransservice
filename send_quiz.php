<?php
/**
 * ===== CRANE RENTAL QUIZ - TELEGRAM BOT HANDLER =====
 * 
 * File: send_quiz.php
 * Purpose: Receive quiz form data via POST and send to Telegram Bot API
 * 
 * Installation:
 * 1. Place this file in your web root or accessible directory
 * 2. Replace YOUR_BOT_TOKEN and YOUR_CHAT_ID with actual values
 * 3. Ensure allow_url_fopen is enabled in php.ini or use cURL
 */

// ===== SECURITY & HEADERS =====
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

// Handle CORS preflight
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
	http_response_code(200);
	exit();
}

// Only accept POST requests
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
	http_response_code(405);
	echo json_encode(['error' => 'Method not allowed']);
	exit();
}

// ===== TELEGRAM BOT CONFIGURATION =====
// IMPORTANT: Replace these with your actual values
define('TELEGRAM_BOT_TOKEN', 'YOUR_BOT_TOKEN_HERE');
define('TELEGRAM_CHAT_ID', 'YOUR_CHAT_ID_HERE');
define('TELEGRAM_API_URL', 'https://api.telegram.org/bot' . TELEGRAM_BOT_TOKEN . '/sendMessage');

// ===== INPUT DATA RETRIEVAL & VALIDATION =====
try {
	// Get JSON input
	$input = file_get_contents('php://input');
	$data = json_decode($input, true);

	if ($data === null && json_last_error() !== JSON_ERROR_NONE) {
		throw new Exception('Invalid JSON format');
	}

	// Extract and sanitize form fields
	$tonnage = sanitizeInput($data['tonnage'] ?? '');
	$craneBrand = sanitizeInput($data['craneBrand'] ?? '');
	$region = sanitizeInput($data['region'] ?? '');
	$rentalPeriod = sanitizeInput($data['rentalPeriod'] ?? '');
	$phone = sanitizeInput($data['phone'] ?? '');
	$notes = sanitizeInput($data['notes'] ?? '');

	// Validate required fields
	if (empty($tonnage) || empty($craneBrand) || empty($region) || empty($rentalPeriod) || empty($phone)) {
		throw new Exception('Missing required fields');
	}

	// ===== BUILD TELEGRAM MESSAGE =====
	$message = formatTelegramMessage($tonnage, $craneBrand, $region, $rentalPeriod, $phone, $notes);

	// ===== SEND TO TELEGRAM =====
	$response = sendToTelegram($message);

	if ($response['success']) {
		http_response_code(200);
		echo json_encode([
			'success' => true,
			'message' => 'Заявка успешно отправлена'
		]);
	} else {
		http_response_code(500);
		echo json_encode([
			'success' => false,
			'error' => 'Failed to send to Telegram: ' . $response['error']
		]);
	}
} catch (Exception $e) {
	http_response_code(400);
	echo json_encode([
		'success' => false,
		'error' => $e->getMessage()
	]);
}

// ===== HELPER FUNCTIONS =====

/**
 * Sanitize user input
 * @param string $input Raw user input
 * @return string Sanitized input
 */
function sanitizeInput($input) {
	// Remove tags and trim whitespace
	$input = strip_tags(trim($input));
	// Remove potentially harmful characters
	$input = htmlspecialchars($input, ENT_QUOTES, 'UTF-8');
	return $input;
}

/**
 * Format the message for Telegram
 * @return string HTML-formatted message
 */
function formatTelegramMessage($tonnage, $craneBrand, $region, $rentalPeriod, $phone, $notes) {
	$message = "<b>🚜 Новая заявка на аренду крана (Квиз)</b>\n\n";
	
	$message .= "<b>Параметры техники:</b>\n";
	$message .= "📊 Тоннаж: <code>{$tonnage}</code>\n";
	$message .= "🏭 Бренд: <code>{$craneBrand}</code>\n\n";
	
	$message .= "<b>Условия аренды:</b>\n";
	$message .= "📍 Регион: <code>{$region}</code>\n";
	$message .= "⏱️ Срок аренды: <code>{$rentalPeriod}</code>\n\n";
	
	$message .= "<b>Контактные данные:</b>\n";
	$message .= "📱 Телефон: <code>{$phone}</code>\n";
	
	if (!empty($notes)) {
		$message .= "\n<b>Дополнительно:</b>\n";
		$message .= "{$notes}\n";
	}
	
	$message .= "\n<i>Время получения: " . date('d.m.Y H:i:s') . " (UTC+6)</i>";
	
	return $message;
}

/**
 * Send message to Telegram Bot API
 * @param string $message HTML-formatted message
 * @return array Response with success flag and error message
 */
function sendToTelegram($message) {
	$postData = [
		'chat_id' => TELEGRAM_CHAT_ID,
		'text' => $message,
		'parse_mode' => 'HTML'
	];

	// Method 1: Using cURL (recommended, more reliable)
	if (function_exists('curl_init')) {
		return sendViaCurl($postData);
	}
	// Method 2: Using file_get_contents (requires allow_url_fopen = On)
	elseif (ini_get('allow_url_fopen')) {
		return sendViaFileGetContents($postData);
	}
	// No method available
	else {
		return [
			'success' => false,
			'error' => 'cURL is not available and allow_url_fopen is disabled'
		];
	}
}

/**
 * Send message via cURL
 * @param array $postData Data to send
 * @return array Response
 */
function sendViaCurl($postData) {
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL, TELEGRAM_API_URL);
	curl_setopt($ch, CURLOPT_POST, true);
	curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($postData));
	curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/json']);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($ch, CURLOPT_TIMEOUT, 10);
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, true);

	$response = curl_exec($ch);
	$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
	$error = curl_error($ch);
	curl_close($ch);

	if ($httpCode === 200 && $response) {
		return ['success' => true];
	} else {
		return [
			'success' => false,
			'error' => "HTTP {$httpCode}: {$error}"
		];
	}
}

/**
 * Send message via file_get_contents
 * @param array $postData Data to send
 * @return array Response
 */
function sendViaFileGetContents($postData) {
	$options = [
		'http' => [
			'method' => 'POST',
			'header' => "Content-Type: application/json\r\n",
			'content' => json_encode($postData),
			'timeout' => 10
		]
	];

	$context = stream_context_create($options);
	$response = @file_get_contents(TELEGRAM_API_URL, false, $context);

	if ($response !== false) {
		return ['success' => true];
	} else {
		return [
			'success' => false,
			'error' => 'Failed to connect to Telegram API'
		];
	}
}
?>
