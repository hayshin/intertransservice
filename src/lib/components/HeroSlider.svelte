<script lang="ts">
	import { onMount } from 'svelte';

	interface Slide {
		title: string;
		subtitle: string;
		tagline: string;
		background: string;
	}

	const slides: Slide[] = [
		{
			title: 'OUR INSPIRATION',
			subtitle: 'OUR PARTNERS',
			tagline: 'You motivate us to develop and grow',
			background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)'
		},
		{
			title: 'OUR COMMITMENT',
			subtitle: 'OUR QUALITY',
			tagline: 'We are passionate about excellence in everything we do',
			background: 'linear-gradient(135deg, #f093fb 0%, #f5576c 100%)'
		},
		{
			title: 'OUR STRENGTH',
			subtitle: 'OUR TEAM',
			tagline: 'Together we deliver solutions that matter',
			background: 'linear-gradient(135deg, #4facfe 0%, #00f2fe 100%)'
		}
	];

	let currentSlide = $state(0);
	let intervalId: number | undefined;

	function nextSlide() {
		currentSlide = (currentSlide + 1) % slides.length;
	}

	function goToSlide(index: number) {
		currentSlide = index;
	}

	function startAutoplay() {
		intervalId = window.setInterval(nextSlide, 5000);
	}

	function stopAutoplay() {
		if (intervalId) {
			clearInterval(intervalId);
		}
	}

	onMount(() => {
		startAutoplay();
		return () => stopAutoplay();
	});
</script>

<div class="relative h-[600px] overflow-hidden" onmouseenter={stopAutoplay} onmouseleave={startAutoplay} role="region" aria-label="Hero slider">
	{#each slides as slide, index}
		<div 
			class="absolute inset-0 transition-opacity duration-1000 flex items-center justify-center text-white"
			style="background: {slide.background}; opacity: {currentSlide === index ? 1 : 0}"
		>
			<div class="container mx-auto px-4 text-center">
				<h2 class="text-xl md:text-2xl font-light mb-2 tracking-widest uppercase">
					{slide.title}
				</h2>
				<h1 class="text-4xl md:text-6xl font-bold mb-6">
					{slide.subtitle}
				</h1>
				<p class="text-xl md:text-2xl mb-8 max-w-3xl mx-auto font-light">
					{slide.tagline}
				</p>
				<div class="flex gap-4 justify-center">
					<a 
						href="/products" 
						class="bg-white text-gray-900 px-8 py-3 rounded-md font-semibold hover:bg-gray-100 transition-colors"
					>
						Our Products
					</a>
					<a 
						href="/contacts" 
						class="bg-transparent border-2 border-white text-white px-8 py-3 rounded-md font-semibold hover:bg-white hover:text-gray-900 transition-colors"
					>
						Contact Us
					</a>
				</div>
			</div>
		</div>
	{/each}

	<!-- Slide Indicators -->
	<div class="absolute bottom-8 left-0 right-0 flex justify-center gap-2">
		{#each slides as _, index}
			<button
				onclick={() => goToSlide(index)}
				class="w-3 h-3 rounded-full transition-all {currentSlide === index ? 'bg-white w-8' : 'bg-white/50'}"
				aria-label="Go to slide {index + 1}"
			></button>
		{/each}
	</div>
</div>

