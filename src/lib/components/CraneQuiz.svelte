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
