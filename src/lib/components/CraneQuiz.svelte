<script lang="ts">
	import * as m from '$lib/paraglide/messages';
	import { getProductsByCapacityPairs } from '$lib/utils/products';

	const totalSteps = 4;

	const tonnageOptions = getProductsByCapacityPairs()
		.filter(function (pair) {
			return pair.sany !== null || pair.xcmg !== null;
		})
		.map(function (pair) {
			const tons = pair.capacity.replace('T', '');
			return {
				value: `${tons} т`,
				label: m.quiz_tonnage_option({ tons })
			};
		});

	const brandOptions = [
		{ value: 'Sany', label: m.quiz_brand_sany() },
		{ value: 'XCMG', label: m.quiz_brand_xcmg() },
		{ value: 'Не важно', label: m.quiz_brand_any() }
	];

	let isModalOpen = false;
	let currentStep = 1;
	let isSubmitting = false;
	let showSuccessMessage = false;

	let formData = {
		tonnage: '',
		craneBrand: '',
		notes: '',
		phone: ''
	};

	let errors: Record<string, string> = {};

	function openQuiz() {
		isModalOpen = true;
	}

	function resetForm() {
		currentStep = 1;
		formData = {
			tonnage: '',
			craneBrand: '',
			notes: '',
			phone: ''
		};
		errors = {};
		showSuccessMessage = false;
	}

	function closeQuiz() {
		isModalOpen = false;
		setTimeout(resetForm, 300);
	}

	function handleBackdropClick(event: MouseEvent) {
		if (event.target === event.currentTarget) {
			closeQuiz();
		}
	}

	function validateStep(step: number): boolean {
		if (step === 1 && !formData.tonnage) {
			errors = { tonnage: m.quiz_error_tonnage() };
			return false;
		}

		if (step === 2 && !formData.craneBrand) {
			errors = { craneBrand: m.quiz_error_brand() };
			return false;
		}

		if (step === 4 && !formData.phone.trim()) {
			errors = { phone: m.quiz_error_phone() };
			return false;
		}

		errors = {};
		return true;
	}

	function goToStep(step: number) {
		if (step > currentStep && !validateStep(currentStep)) {
			return;
		}

		currentStep = step;
	}

	function nextStep() {
		if (!validateStep(currentStep)) {
			return;
		}

		if (currentStep < totalSteps) {
			currentStep += 1;
		}
	}

	function selectTonnage(value: string) {
		formData.tonnage = value;
		errors = { ...errors, tonnage: '' };
	}

	function selectBrand(value: string) {
		formData.craneBrand = value;
		errors = { ...errors, craneBrand: '' };
	}

	async function submitForm() {
		if (!validateStep(4)) {
			return;
		}

		isSubmitting = true;
		errors = {};

		try {
			const response = await fetch('/api/quiz', {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify(formData)
			});

			const result = (await response.json()) as { success?: boolean };

			if (response.ok && result.success) {
				showSuccessMessage = true;
				setTimeout(closeQuiz, 3000);
			} else {
				errors.submit = m.quiz_error_submit();
			}
		} catch (error) {
			console.error('Error:', error);
			errors.submit = m.quiz_error_connection();
		} finally {
			isSubmitting = false;
		}
	}

	function getStepTitle(): string {
		if (currentStep === 1) return m.quiz_step1_title();
		if (currentStep === 2) return m.quiz_step2_title();
		if (currentStep === 3) return m.quiz_step3_title();
		return m.quiz_step4_title();
	}

	function getStepHint(): string {
		if (currentStep === 1) return m.quiz_step1_hint();
		if (currentStep === 2) return m.quiz_step2_hint();
		if (currentStep === 3) return m.quiz_step3_hint();
		return m.quiz_step4_hint();
	}
</script>

<button class="quiz-fab" onclick={openQuiz} title={m.quiz_fab_title()}>
	{m.quiz_fab_label()}
</button>

{#if isModalOpen}
	<div class="quiz-modal-backdrop" onclick={handleBackdropClick} role="presentation">
		<div class="quiz-modal" role="dialog" aria-modal="true" aria-labelledby="quiz-title">
			<button class="quiz-close-btn" onclick={closeQuiz} aria-label={m.quiz_close_aria()}>
				✕
			</button>

			<div class="quiz-header">
				<h2 id="quiz-title" class="quiz-title">{m.quiz_modal_title()}</h2>
				<div class="quiz-steps" aria-hidden="true">
					{#each Array.from({ length: totalSteps }, (_, i) => i + 1) as step}
						<div
							class="quiz-step-dot"
							class:quiz-step-dot--done={currentStep > step}
							class:quiz-step-dot--active={currentStep === step}
						></div>
					{/each}
				</div>
				<p class="quiz-subtitle">
					{m.quiz_step_of({ current: String(currentStep), total: String(totalSteps) })}
				</p>
			</div>

			<div class="quiz-content">
				{#if showSuccessMessage}
					<div class="quiz-success-message">
						<div class="quiz-success-icon">✓</div>
						<h3>{m.quiz_success_title()}</h3>
						<p>{m.quiz_success_text()}</p>
					</div>
				{:else}
					<div class="quiz-step-header">
						<h3 class="quiz-step-title">{getStepTitle()}</h3>
						<p class="quiz-step-hint">{getStepHint()}</p>
					</div>

					{#if currentStep === 1}
						<div class="quiz-step">
							<div class="quiz-options" role="listbox" aria-label={m.quiz_step1_title()}>
								{#each tonnageOptions as option}
									<button
										type="button"
										class="quiz-option"
										class:quiz-option--selected={formData.tonnage === option.value}
										onclick={() => selectTonnage(option.value)}
									>
										{option.label}
									</button>
								{/each}
							</div>
							{#if errors.tonnage}
								<span class="quiz-error">{errors.tonnage}</span>
							{/if}
						</div>
					{/if}

					{#if currentStep === 2}
						<div class="quiz-step">
							<div class="quiz-options" role="listbox" aria-label={m.quiz_step2_title()}>
								{#each brandOptions as option}
									<button
										type="button"
										class="quiz-option"
										class:quiz-option--selected={formData.craneBrand === option.value}
										onclick={() => selectBrand(option.value)}
									>
										{option.label}
									</button>
								{/each}
							</div>
							{#if errors.craneBrand}
								<span class="quiz-error">{errors.craneBrand}</span>
							{/if}
						</div>
					{/if}

					{#if currentStep === 3}
						<div class="quiz-step">
							<div class="quiz-form-group">
								<textarea
									id="notes"
									bind:value={formData.notes}
									placeholder={m.quiz_step3_placeholder()}
									class="quiz-input"
									rows="4"
								></textarea>
							</div>
						</div>
					{/if}

					{#if currentStep === 4}
						<div class="quiz-step">
							<div class="quiz-form-group">
								<label for="phone">{m.quiz_phone_label()}</label>
								<input
									id="phone"
									type="tel"
									bind:value={formData.phone}
									placeholder={m.quiz_phone_placeholder()}
									class="quiz-input {errors.phone ? 'error' : ''}"
								/>
								{#if errors.phone}
									<span class="quiz-error">{errors.phone}</span>
								{/if}
							</div>

							{#if errors.submit}
								<div class="quiz-error-message">{errors.submit}</div>
							{/if}
						</div>
					{/if}

					<div class="quiz-navigation">
						{#if currentStep > 1}
							<button
								type="button"
								class="quiz-btn quiz-btn-back"
								onclick={() => goToStep(currentStep - 1)}
								disabled={isSubmitting}
							>
								{m.quiz_btn_back()}
							</button>
						{/if}

						{#if currentStep < totalSteps}
							<button
								type="button"
								class="quiz-btn quiz-btn-primary"
								onclick={nextStep}
								disabled={isSubmitting}
							>
								{m.quiz_btn_next()}
							</button>
						{:else}
							<button
								type="button"
								class="quiz-btn quiz-btn-primary"
								onclick={submitForm}
								disabled={isSubmitting}
							>
								{isSubmitting ? m.quiz_btn_submitting() : m.quiz_btn_submit()}
							</button>
						{/if}
					</div>
				{/if}
			</div>
		</div>
	</div>
{/if}

<style>
	.quiz-fab {
		position: fixed;
		bottom: 24px;
		right: 24px;
		z-index: 9999;
		padding: 14px 22px;
		border: none;
		border-radius: 999px;
		background: #1a365d;
		color: #ffffff;
		font-size: 14px;
		font-weight: 600;
		line-height: 1.3;
		cursor: pointer;
		box-shadow: 0 8px 24px rgba(26, 54, 93, 0.35);
		transition:
			transform 0.2s ease,
			box-shadow 0.2s ease,
			background 0.2s ease;
		font-family: inherit;
		max-width: calc(100vw - 48px);
		text-align: center;
	}

	.quiz-fab:hover {
		background: #234876;
		transform: translateY(-2px);
		box-shadow: 0 12px 28px rgba(26, 54, 93, 0.45);
	}

	.quiz-fab:active {
		transform: translateY(0);
	}

	.quiz-modal-backdrop {
		position: fixed;
		inset: 0;
		background-color: rgba(15, 41, 66, 0.55);
		display: flex;
		align-items: center;
		justify-content: center;
		z-index: 10000;
		padding: 20px;
		animation: quiz-fade-in 0.25s ease;
	}

	@keyframes quiz-fade-in {
		from {
			opacity: 0;
		}
		to {
			opacity: 1;
		}
	}

	.quiz-modal {
		position: relative;
		background: #ffffff;
		border-radius: 16px;
		width: 100%;
		max-width: 480px;
		box-shadow: 0 20px 50px rgba(15, 41, 66, 0.2);
		overflow: hidden;
		animation: quiz-slide-up 0.3s ease;
	}

	@keyframes quiz-slide-up {
		from {
			opacity: 0;
			transform: translateY(20px);
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
		border: 1px solid #d6e4f5;
		background: #ffffff;
		color: #1a365d;
		cursor: pointer;
		border-radius: 50%;
		font-size: 16px;
		display: flex;
		align-items: center;
		justify-content: center;
		transition: all 0.2s ease;
		z-index: 1;
	}

	.quiz-close-btn:hover {
		background: #eef4fb;
		border-color: #1a365d;
	}

	.quiz-header {
		padding: 28px 28px 0;
		background: linear-gradient(180deg, #eef4fb 0%, #ffffff 100%);
	}

	.quiz-title {
		font-size: 20px;
		font-weight: 700;
		margin: 0 0 16px;
		color: #0f2942;
		padding-right: 36px;
	}

	.quiz-steps {
		display: flex;
		gap: 8px;
		margin-bottom: 10px;
	}

	.quiz-step-dot {
		flex: 1;
		height: 4px;
		border-radius: 999px;
		background: #d6e4f5;
		transition: background 0.3s ease;
	}

	.quiz-step-dot--active,
	.quiz-step-dot--done {
		background: #1a365d;
	}

	.quiz-subtitle {
		font-size: 13px;
		color: #5a7a9a;
		margin: 0 0 20px;
	}

	.quiz-content {
		padding: 0 28px 28px;
	}

	.quiz-step-header {
		margin-bottom: 20px;
	}

	.quiz-step-title {
		font-size: 18px;
		font-weight: 700;
		color: #0f2942;
		margin: 0 0 6px;
	}

	.quiz-step-hint {
		font-size: 14px;
		color: #5a7a9a;
		margin: 0;
		line-height: 1.4;
	}

	.quiz-step {
		animation: quiz-fade-in 0.25s ease;
	}

	.quiz-options {
		display: grid;
		grid-template-columns: repeat(2, 1fr);
		gap: 10px;
	}

	.quiz-option {
		padding: 14px 12px;
		border: 2px solid #d6e4f5;
		border-radius: 10px;
		background: #ffffff;
		color: #0f2942;
		font-size: 15px;
		font-weight: 600;
		cursor: pointer;
		transition: all 0.2s ease;
		font-family: inherit;
		text-align: center;
		line-height: 1.3;
	}

	.quiz-option:hover {
		border-color: #1a365d;
		background: #eef4fb;
	}

	.quiz-option--selected {
		border-color: #1a365d;
		background: #1a365d;
		color: #ffffff;
		box-shadow: 0 4px 12px rgba(26, 54, 93, 0.25);
	}

	.quiz-option--selected:hover {
		background: #234876;
		border-color: #234876;
	}

	.quiz-form-group {
		display: flex;
		flex-direction: column;
	}

	.quiz-form-group label {
		font-size: 14px;
		font-weight: 600;
		color: #0f2942;
		margin-bottom: 8px;
	}

	.quiz-input {
		padding: 14px 16px;
		border: 2px solid #d6e4f5;
		border-radius: 10px;
		font-size: 15px;
		font-family: inherit;
		transition: all 0.2s ease;
		color: #0f2942;
		background-color: #ffffff;
		width: 100%;
		box-sizing: border-box;
	}

	.quiz-input:focus {
		outline: none;
		border-color: #1a365d;
		box-shadow: 0 0 0 3px rgba(26, 54, 93, 0.12);
	}

	.quiz-input::placeholder {
		color: #8aa4be;
	}

	.quiz-input:global(.error) {
		border-color: #c53030;
		background-color: #fff5f5;
	}

	textarea.quiz-input {
		resize: vertical;
		min-height: 110px;
		line-height: 1.5;
	}

	.quiz-error {
		display: block;
		color: #c53030;
		font-size: 13px;
		margin-top: 10px;
		font-weight: 500;
	}

	.quiz-error-message {
		padding: 12px 14px;
		background-color: #fff5f5;
		border: 1px solid #feb2b2;
		color: #c53030;
		border-radius: 10px;
		font-size: 14px;
		margin-top: 12px;
		text-align: center;
	}

	.quiz-navigation {
		display: flex;
		gap: 10px;
		margin-top: 24px;
	}

	.quiz-btn {
		flex: 1;
		padding: 14px 18px;
		border-radius: 10px;
		font-size: 15px;
		font-weight: 600;
		cursor: pointer;
		transition: all 0.2s ease;
		font-family: inherit;
	}

	.quiz-btn:disabled {
		opacity: 0.55;
		cursor: not-allowed;
	}

	.quiz-btn-primary {
		border: none;
		background: #1a365d;
		color: #ffffff;
	}

	.quiz-btn-primary:hover:not(:disabled) {
		background: #234876;
		box-shadow: 0 4px 14px rgba(26, 54, 93, 0.3);
		transform: translateY(-1px);
	}

	.quiz-btn-back {
		border: 2px solid #d6e4f5;
		background: #ffffff;
		color: #1a365d;
	}

	.quiz-btn-back:hover:not(:disabled) {
		border-color: #1a365d;
		background: #eef4fb;
	}

	.quiz-success-message {
		text-align: center;
		padding: 24px 8px 8px;
	}

	.quiz-success-icon {
		width: 56px;
		height: 56px;
		background-color: #1a365d;
		color: #ffffff;
		border-radius: 50%;
		display: flex;
		align-items: center;
		justify-content: center;
		font-size: 28px;
		margin: 0 auto 16px;
		font-weight: 700;
	}

	.quiz-success-message h3 {
		font-size: 18px;
		color: #0f2942;
		margin: 0 0 8px;
		font-weight: 700;
	}

	.quiz-success-message p {
		font-size: 14px;
		color: #5a7a9a;
		margin: 0;
		line-height: 1.5;
	}

	@media (max-width: 768px) {
		.quiz-fab {
			bottom: 16px;
			right: 16px;
			font-size: 13px;
			padding: 12px 18px;
		}

		.quiz-modal {
			max-width: calc(100% - 16px);
		}

		.quiz-header,
		.quiz-content {
			padding-left: 20px;
			padding-right: 20px;
		}

		.quiz-content {
			padding-bottom: 20px;
		}
	}

	@media (max-width: 480px) {
		.quiz-modal-backdrop {
			padding: 12px;
			align-items: flex-end;
		}

		.quiz-modal {
			border-radius: 16px 16px 0 0;
		}

		.quiz-options {
			grid-template-columns: 1fr;
		}

		.quiz-navigation {
			flex-direction: column-reverse;
		}

		.quiz-fab {
			left: 16px;
			right: 16px;
			max-width: none;
		}
	}
</style>
