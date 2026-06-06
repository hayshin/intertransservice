import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { env } from '$env/dynamic/private';

// API route must not be prerendered (POST handler).
export const prerender = false;

interface QuizPayload {
	tonnage?: string;
	craneBrand?: string;
	region?: string;
	rentalPeriod?: string;
	phone?: string;
	notes?: string;
}

function sanitize(value: string): string {
	return value.trim().slice(0, 2000);
}

function parseChatId(chatId: string): string | number {
	const trimmed = chatId.trim();
	if (/^-?\d+$/.test(trimmed)) {
		return Number(trimmed);
	}
	return trimmed;
}

function buildTelegramMessage(data: QuizPayload): string {
	const tonnage = sanitize(data.tonnage ?? '') || '—';
	const craneBrand = sanitize(data.craneBrand ?? '') || '—';
	const region = sanitize(data.region ?? '') || 'не указан';
	const phone = sanitize(data.phone ?? '') || '—';
	const notes = sanitize(data.notes ?? '') || '—';

	return [
		'🚀 Новая заявка с сайта',
		'',
		`Тоннаж: ${tonnage}`,
		`Бренд крана: ${craneBrand}`,
		`Регион: ${region}`,
		`Телефон: ${phone}`,
		`Пожелания: ${notes}`
	].join('\n');
}

/**
 * To obtain TELEGRAM_CHAT_ID:
 * 1. Send any message to your bot in Telegram.
 * 2. Open: https://api.telegram.org/bot<TELEGRAM_BOT_TOKEN>/getUpdates
 * 3. Find "chat":{"id": ...} in the JSON response.
 */
export const POST: RequestHandler = async function ({ request }) {
	try {
		const botToken = env.TELEGRAM_BOT_TOKEN;
		const chatId = env.TELEGRAM_CHAT_ID;

		if (!botToken || !chatId) {
			console.error('Quiz API: TELEGRAM_BOT_TOKEN or TELEGRAM_CHAT_ID is not set');
			return json({ success: false, error: 'Telegram is not configured' }, { status: 500 });
		}

		let body: QuizPayload;

		try {
			body = (await request.json()) as QuizPayload;
		} catch {
			return json({ success: false, error: 'Invalid JSON body' }, { status: 400 });
		}

		if (!body.tonnage?.trim() || !body.craneBrand?.trim() || !body.phone?.trim()) {
			return json({ success: false, error: 'Missing required fields' }, { status: 400 });
		}

		const message = buildTelegramMessage(body);

		const telegramResponse = await fetch(
			`https://api.telegram.org/bot${botToken}/sendMessage`,
			{
				method: 'POST',
				headers: { 'Content-Type': 'application/json' },
				body: JSON.stringify({
					chat_id: parseChatId(chatId),
					text: message
				})
			}
		);

		const telegramResult = (await telegramResponse.json()) as {
			ok?: boolean;
			description?: string;
		};

		if (!telegramResponse.ok || !telegramResult.ok) {
			console.error('Telegram API error:', telegramResult);
			return json(
				{ success: false, error: telegramResult.description ?? 'Telegram send failed' },
				{ status: 502 }
			);
		}

		return json({ success: true });
	} catch (error) {
		console.error('Quiz API error:', error);
		return json({ success: false, error: 'Internal server error' }, { status: 500 });
	}
};
