<script lang="ts">
	import { onMount } from 'svelte';

	// ===== STATE MANAGEMENT =====
	let isModalOpen = false;
	let currentStep = 1;
	const totalSteps = 3;
	let isSubmitting = false;
	let showSuccessMessage = false;

	// Form data
	let formData = {
		tonnage: '',
		craneBrand: '',
		region: '',
		rentalPeriod: '',
		phone: '',
		notes: ''
	};

	// Error messages
	let errors: Record<string, string> = {};

	// ===== MODAL FUNCTIONS =====
	function openQuiz() {
		isModalOpen = true;
	}

	function closeQuiz() {
		isModalOpen = false;
		// Reset after modal closes
		setTimeout(() => {
			currentStep = 1;
			formData = {
				tonnage: '',
				craneBrand: '',
				region: '',
				rentalPeriod: '',
				phone: '',
				notes: ''
			};
			errors = {};
			showSuccessMessage = false;
		}, 300);
	}

	// Close modal when clicking on backdrop
	function handleBackdropClick(event: MouseEvent) {
		if (event.target === event.currentTarget) {
			closeQuiz();
		}
	}

	// ===== STEP NAVIGATION =====
	function goToStep(step: number) {
		if (step === 2) {
			// Validate step 1 before moving to step 2
			if (!formData.tonnage || !formData.craneBrand) {
				errors = {
					...errors,
					tonnage: !formData.tonnage ? 'Выберите тоннаж' : '',
					craneBrand: !formData.craneBrand ? 'Выберите бренд крана' : ''
				};
				return;
			}
			errors = {};
		}

		if (step === 3) {
			// Validate step 2 before moving to step 3
			if (!formData.region || !formData.rentalPeriod) {
				errors = {
					...errors,
					region: !formData.region ? 'Укажите регион' : '',
					rentalPeriod: !formData.rentalPeriod ? 'Укажите срок аренды' : ''
				};
				return;
			}
			errors = {};
		}

		currentStep = step;
	}

	// ===== FORM SUBMISSION =====
	async function submitForm() {
		// Validate step 3
		if (!formData.phone) {
			errors = { phone: 'Укажите номер телефона' };
			return;
		}

		isSubmitting = true;
		errors = {};

		try {
			const response = await fetch('/send_quiz.php', {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify(formData)
			});

			if (response.ok) {
				showSuccessMessage = true;
				// Close modal after 3 seconds
				setTimeout(() => {
					closeQuiz();
				}, 3000);
			} else {
				errors.submit = 'Ошибка при отправке. Попробуйте позже.';
			}
		} catch (error) {
			console.error('Error:', error);
			errors.submit = 'Ошибка соединения. Проверьте интернет.';
		} finally {
			isSubmitting = false;
		}
	}

	// ===== UTILITY FUNCTIONS =====
	function getProgressPercentage(): number {
		return (currentStep / totalSteps) * 100;
	}

	function formatPhoneNumber(value: string): string {
		// Simple phone formatting: remove non-digits and format
		const digits = value.replace(/\D/g, '');
		if (digits.length === 0) return '';
		if (digits.length <= 3) return digits;
		if (digits.length <= 6) return `${digits.slice(0, 3)}-${digits.slice(3)}`;
		return `${digits.slice(0, 3)}-${digits.slice(3, 6)}-${digits.slice(6, 10)}`;
	}

	onMount(() => {
		// Component is mounted
	});
</script>

<!-- ===== FIXED BUTTON ===== -->
<button class="quiz-button" on:click={openQuiz} title="Рассчитать стоимость аренды">
	<span class="quiz-button-icon">📊</span>
	<span class="quiz-button-text">Расчет</span>
</button>

<!-- ===== MODAL BACKDROP ===== -->
{#if isModalOpen}
	<div class="quiz-modal-backdrop" on:click={handleBackdropClick} role="presentation">
		<!-- ===== MODAL CONTAINER ===== -->
		<div class="quiz-modal" role="dialog" aria-modal="true" aria-labelledby="quiz-title">
			<!-- ===== CLOSE BUTTON ===== -->
			<button class="quiz-close-btn" on:click={closeQuiz} aria-label="Закрыть форму">
				✕
			</button>

			<!-- ===== PROGRESS BAR ===== -->
			<div class="quiz-progress-container">
				<div class="quiz-progress-bar" style="width: {getProgressPercentage()}%"></div>
			</div>

			<!-- ===== MODAL CONTENT ===== -->
			<div class="quiz-content">
				<h2 id="quiz-title" class="quiz-title">Рассчитать стоимость аренды</h2>
				<p class="quiz-subtitle">Шаг {currentStep} из {totalSteps}</p>

				{#if showSuccessMessage}
					<!-- ===== SUCCESS MESSAGE ===== -->
					<div class="quiz-success-message">
						<div class="quiz-success-icon">✓</div>
						<h3>Спасибо за вашу заявку!</h3>
						<p>Менеджер свяжется с Вами в WhatsApp в ближайшее время.</p>
					</div>
				{:else}
					<!-- ===== STEP 1: EQUIPMENT PARAMETERS ===== -->
					{#if currentStep === 1}
						<div class="quiz-step">
							<div class="quiz-form-group">
								<label for="tonnage">Необходимый тоннаж</label>
								<select
									id="tonnage"
									bind:value={formData.tonnage}
									class="quiz-input {errors.tonnage ? 'error' : ''}"
								>
									<option value="">-- Выберите вариант --</option>
									<option value="25 тонн">25 тонн</option>
									<option value="50 тонн">50 тонн</option>
									<option value="100 тонн">100 тонн</option>
									<option value="200 тонн">200 тонн</option>
									<option value="Нужна помощь в подборе">Нужна помощь в подборе</option>
								</select>
								{#if errors.tonnage}
									<span class="quiz-error">{errors.tonnage}</span>
								{/if}
							</div>

							<div class="quiz-form-group">
								<label for="craneBrand">Бренд крана</label>
								<select
									id="craneBrand"
									bind:value={formData.craneBrand}
									class="quiz-input {errors.craneBrand ? 'error' : ''}"
								>
									<option value="">-- Выберите вариант --</option>
									<option value="Любой / По рекомендации">Любой / По рекомендации</option>
									<option value="Liebherr">Liebherr</option>
									<option value="XCMG">XCMG</option>
									<option value="Zoomlion">Zoomlion</option>
								</select>
								{#if errors.craneBrand}
									<span class="quiz-error">{errors.craneBrand}</span>
								{/if}
							</div>

							<div class="quiz-navigation">
								<button
									class="quiz-btn quiz-btn-next"
									on:click={() => goToStep(2)}
									disabled={isSubmitting}
								>
									Далее →
								</button>
							</div>
						</div>
					{/if}

					<!-- ===== STEP 2: RENTAL CONDITIONS ===== -->
					{#if currentStep === 2}
						<div class="quiz-step">
							<div class="quiz-form-group">
								<label for="region">Регион работы в Казахстане</label>
								<input
									id="region"
									type="text"
									bind:value={formData.region}
									placeholder="Например: Атырау, Актау"
									class="quiz-input {errors.region ? 'error' : ''}"
								/>
								{#if errors.region}
									<span class="quiz-error">{errors.region}</span>
								{/if}
							</div>

							<div class="quiz-form-group">
								<label for="rentalPeriod">Срок аренды (смен / дней)</label>
								<input
									id="rentalPeriod"
									type="number"
									bind:value={formData.rentalPeriod}
									placeholder="Например: 3"
									min="1"
									class="quiz-input {errors.rentalPeriod ? 'error' : ''}"
								/>
								{#if errors.rentalPeriod}
									<span class="quiz-error">{errors.rentalPeriod}</span>
								{/if}
							</div>

							<div class="quiz-navigation">
								<button
									class="quiz-btn quiz-btn-back"
									on:click={() => goToStep(1)}
									disabled={isSubmitting}
								>
									← Назад
								</button>
								<button
									class="quiz-btn quiz-btn-next"
									on:click={() => goToStep(3)}
									disabled={isSubmitting}
								>
									Далее →
								</button>
							</div>
						</div>
					{/if}

					<!-- ===== STEP 3: CONTACTS & CUSTOMIZATION ===== -->
					{#if currentStep === 3}
						<div class="quiz-step">
							<div class="quiz-form-group">
								<label for="phone">Номер телефона</label>
								<input
									id="phone"
									type="tel"
									bind:value={formData.phone}
									placeholder="+7 (XXX) XXX-XX-XX"
									class="quiz-input {errors.phone ? 'error' : ''}"
								/>
								{#if errors.phone}
									<span class="quiz-error">{errors.phone}</span>
								{/if}
							</div>

							<div class="quiz-form-group">
								<label for="notes">Заметка по желанию (доп. требования)</label>
								<textarea
									id="notes"
									bind:value={formData.notes}
									placeholder="Укажите особенности груза, площадки или требования к пропускам..."
									class="quiz-input"
									rows="4"
								></textarea>
							</div>

							{#if errors.submit}
								<div class="quiz-error-message">{errors.submit}</div>
							{/if}

							<div class="quiz-navigation">
								<button
									class="quiz-btn quiz-btn-back"
									on:click={() => goToStep(2)}
									disabled={isSubmitting}
								>
									← Назад
								</button>
								<button
									class="quiz-btn quiz-btn-submit"
									on:click={submitForm}
									disabled={isSubmitting}
								>
									{isSubmitting ? 'Отправка...' : 'Получить расчет стоимости'}
								</button>
							</div>
						</div>
					{/if}
				{/if}
			</div>
		</div>
	</div>
{/if}

<style>
	.quiz-button {
		position: fixed;
		bottom: 25px;
		right: 25px;
		z-index: 9999;
		width: 120px;
		height: 120px;
		border-radius: 50%;
		background: linear-gradient(135deg, #ffa500, #ff8c00);
		color: white;
		border: none;
		cursor: pointer;
		box-shadow: 0 4px 15px rgba(255, 140, 0, 0.3);
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		font-weight: 600;
		font-size: 12px;
		transition: all 0.3s ease;
		font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell,
			sans-serif;
	}

	.quiz-button:hover {
		transform: translateY(-8px);
		box-shadow: 0 8px 25px rgba(255, 140, 0, 0.5);
		background: linear-gradient(135deg, #ffb333, #ff9933);
	}

	.quiz-button:active {
		transform: translateY(-4px);
	}

	.quiz-button-icon {
		font-size: 32px;
		margin-bottom: 4px;
		line-height: 1;
	}

	.quiz-button-text {
		font-size: 11px;
		text-align: center;
		letter-spacing: 0.5px;
	}

	.quiz-modal-backdrop {
		position: fixed;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		background-color: rgba(0, 0, 0, 0.5);
		display: flex;
		align-items: center;
		justify-content: center;
		z-index: 10000;
		padding: 20px;
		animation: fadeIn 0.3s ease;
	}

	@keyframes fadeIn {
		from {
			opacity: 0;
		}
		to {
			opacity: 1;
		}
	}

	.quiz-modal {
		position: relative;
		background: white;
		border-radius: 12px;
		width: 100%;
		max-width: 500px;
		box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
		overflow: hidden;
		animation: slideUp 0.3s ease;
	}

	@keyframes slideUp {
		from {
			opacity: 0;
			transform: translateY(30px);
		}
		to {
			opacity: 1;
			transform: translateY(0);
		}
	}

	.quiz-close-btn {
		position: absolute;
		top: 16px;
		right: 16px;
		width: 32px;
		height: 32px;
		border: none;
		background: #f0f0f0;
		color: #333;
		cursor: pointer;
		border-radius: 50%;
		font-size: 18px;
		display: flex;
		align-items: center;
		justify-content: center;
		transition: all 0.2s ease;
		z-index: 10001;
	}

	.quiz-close-btn:hover {
		background: #e0e0e0;
		transform: rotate(90deg);
	}

	.quiz-progress-container {
		height: 4px;
		background-color: #e0e0e0;
		overflow: hidden;
	}

	.quiz-progress-bar {
		height: 100%;
		background: linear-gradient(90deg, #ffa500, #ff8c00);
		transition: width 0.4s ease;
	}

	.quiz-content {
		padding: 40px 30px 30px;
	}

	.quiz-title {
		font-size: 24px;
		font-weight: 700;
		margin: 0 0 8px;
		color: #333;
	}

	.quiz-subtitle {
		font-size: 14px;
		color: #999;
		margin: 0 0 24px;
	}

	.quiz-step {
		animation: fadeIn 0.3s ease;
	}

	.quiz-form-group {
		margin-bottom: 24px;
		display: flex;
		flex-direction: column;
	}

	.quiz-form-group label {
		font-size: 14px;
		font-weight: 600;
		color: #333;
		margin-bottom: 8px;
		display: block;
	}

	.quiz-input {
		padding: 12px 14px;
		border: 2px solid #e0e0e0;
		border-radius: 6px;
		font-size: 14px;
		font-family: inherit;
		transition: all 0.2s ease;
		color: #333;
		background-color: white;
	}

	.quiz-input:focus {
		outline: none;
		border-color: #ffa500;
		box-shadow: 0 0 0 3px rgba(255, 165, 0, 0.1);
	}

	.quiz-input::placeholder {
		color: #aaa;
	}

	.quiz-input:disabled {
		background-color: #f5f5f5;
		cursor: not-allowed;
		opacity: 0.6;
	}

	.quiz-input:global(.error) {
		border-color: #e74c3c;
		background-color: #fadbd8;
	}

	select.quiz-input {
		cursor: pointer;
		background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
		background-repeat: no-repeat;
		background-position: right 10px center;
		background-size: 20px;
		padding-right: 36px;
		appearance: none;
	}

	textarea.quiz-input {
		resize: vertical;
		min-height: 100px;
		font-family: inherit;
		line-height: 1.5;
	}

	.quiz-error {
		display: block;
		color: #e74c3c;
		font-size: 12px;
		margin-top: 6px;
		font-weight: 500;
	}

	.quiz-error-message {
		padding: 12px;
		background-color: #fadbd8;
		border: 1px solid #e74c3c;
		color: #c0392b;
		border-radius: 6px;
		font-size: 14px;
		margin-bottom: 20px;
		text-align: center;
	}

	.quiz-navigation {
		display: flex;
		gap: 12px;
		margin-top: 28px;
	}

	.quiz-btn {
		flex: 1;
		padding: 12px 16px;
		border: none;
		border-radius: 6px;
		font-size: 14px;
		font-weight: 600;
		cursor: pointer;
		transition: all 0.2s ease;
		font-family: inherit;
		white-space: nowrap;
	}

	.quiz-btn:disabled {
		opacity: 0.5;
		cursor: not-allowed;
	}

	.quiz-btn-next,
	.quiz-btn-submit {
		background: linear-gradient(135deg, #ffa500, #ff8c00);
		color: white;
	}

	.quiz-btn-next:hover:not(:disabled),
	.quiz-btn-submit:hover:not(:disabled) {
		background: linear-gradient(135deg, #ffb333, #ff9933);
		box-shadow: 0 4px 12px rgba(255, 140, 0, 0.3);
		transform: translateY(-2px);
	}

	.quiz-btn-back {
		background-color: #f0f0f0;
		color: #333;
	}

	.quiz-btn-back:hover:not(:disabled) {
		background-color: #e0e0e0;
		transform: translateY(-2px);
	}

	.quiz-success-message {
		text-align: center;
		padding: 40px 20px;
	}

	.quiz-success-icon {
		width: 60px;
		height: 60px;
		background-color: #2ecc71;
		color: white;
		border-radius: 50%;
		display: flex;
		align-items: center;
		justify-content: center;
		font-size: 32px;
		margin: 0 auto 20px;
		font-weight: bold;
	}

	.quiz-success-message h3 {
		font-size: 18px;
		color: #333;
		margin: 0 0 12px;
		font-weight: 700;
	}

	.quiz-success-message p {
		font-size: 14px;
		color: #666;
		margin: 0;
		line-height: 1.5;
	}

	@media (max-width: 768px) {
		.quiz-modal {
			max-width: calc(100% - 20px);
		}

		.quiz-content {
			padding: 40px 20px 20px;
		}

		.quiz-title {
			font-size: 20px;
		}

		.quiz-button {
			width: 100px;
			height: 100px;
			bottom: 20px;
			right: 20px;
		}

		.quiz-button-icon {
			font-size: 28px;
		}

		.quiz-button-text {
			font-size: 10px;
		}

		.quiz-navigation {
			gap: 10px;
		}

		.quiz-btn {
			padding: 10px 12px;
			font-size: 13px;
		}
	}

	@media (max-width: 480px) {
		.quiz-modal-backdrop {
			padding: 10px;
		}

		.quiz-content {
			padding: 35px 16px 16px;
		}

		.quiz-title {
			font-size: 18px;
		}

		.quiz-subtitle {
			font-size: 12px;
		}

		.quiz-form-group {
			margin-bottom: 18px;
		}

		.quiz-form-group label {
			font-size: 13px;
		}

		.quiz-input {
			padding: 10px 12px;
			font-size: 13px;
		}

		.quiz-button {
			width: 80px;
			height: 80px;
			bottom: 15px;
			right: 15px;
		}

		.quiz-button-icon {
			font-size: 24px;
			margin-bottom: 2px;
		}

		.quiz-button-text {
			font-size: 9px;
		}

		.quiz-close-btn {
			width: 28px;
			height: 28px;
			font-size: 16px;
			top: 12px;
			right: 12px;
		}

		.quiz-navigation {
			flex-direction: column;
			gap: 8px;
		}

		.quiz-btn {
			padding: 12px 16px;
		}
	}
</style>