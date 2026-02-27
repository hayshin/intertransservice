<script lang="ts">
	import { onMount } from 'svelte';
	import * as m from '$lib/paraglide/messages';
    const slide1 = '/carousel/1.png';
    const slide2 = '/carousel/2.png';
    const slide3 = '/carousel/3.png';



	interface Slide {
		titleSmall: string;
		titleLarge: string;
		tagline: string;
		image: any;
	}

	const slides: Slide[] = [
		{
			titleSmall: m.home_hero_slide1_small(),
			titleLarge: m.home_hero_slide1_large(),
			tagline: m.home_hero_slide1_tagline(),
			image: slide1
		},
		{
			titleSmall: m.home_hero_slide2_small(),
			titleLarge: m.home_hero_slide2_large(),
			tagline: m.home_hero_slide2_tagline(),
			image: slide2
		},
		{
			titleSmall: m.home_hero_slide3_small(),
			titleLarge: m.home_hero_slide3_large(),
			tagline: m.home_hero_slide3_tagline(),
			image: slide3
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
		intervalId = window.setInterval(nextSlide, 6000);
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

<div 
	class="relative h-[600px] lg:h-[700px] overflow-hidden" 
	onmouseenter={stopAutoplay} 
	onmouseleave={startAutoplay} 
	role="region" 
	aria-label="Hero slider"
>
	<!-- Background with industrial pattern -->
	<div class="absolute inset-0 bg-[#0f2942] pattern-overlay"></div>
	
	<!-- Decorative elements -->
	<div class="absolute top-0 right-0 w-1/2 h-full bg-gradient-to-l from-[#c9a227]/10 to-transparent"></div>
	<div class="absolute bottom-0 left-0 w-full h-32 bg-gradient-to-t from-[#0a1f33] to-transparent"></div>

	{#each slides as slide, index}
		<div 
			class="absolute inset-0 flex items-center transition-all duration-1000"
			style="opacity: {currentSlide === index ? 1 : 0}; transform: translateX({currentSlide === index ? 0 : (currentSlide > index ? -100 : 100)}px); pointer-events: {currentSlide === index ? 'auto' : 'none'}"
		>
			<!-- Slide Background Image -->
			<div class="absolute inset-0 z-0">
				<enhanced:img 
					src={slide.image} 
					alt="" 
					class="w-full h-full object-cover opacity-40"
				/>
				<div class="absolute inset-0 bg-gradient-to-r from-[#0f2942] via-[#0f2942]/80 to-transparent"></div>
			</div>

			<div class="container mx-auto px-4 relative z-10">
				<div class="max-w-3xl">
					<!-- Small title -->
					<div class="flex items-center gap-4 mb-4">
						<div class="w-16 h-[2px] bg-[#c9a227]"></div>
						<span class="text-[#c9a227] text-sm md:text-base font-semibold tracking-[0.3em] uppercase">
							{slide.titleSmall}
						</span>
					</div>
					
					<!-- Large title -->
					<h1 class="text-5xl md:text-7xl lg:text-8xl font-bold text-white mb-6 leading-tight">
						{slide.titleLarge}
					</h1>
					
					<!-- Tagline -->
					<p class="text-xl md:text-2xl text-gray-300 mb-10 font-light">
						{slide.tagline}
					</p>
					
					<!-- CTAs -->
					<div class="flex flex-wrap gap-4">
						<a 
							href="/products" 
							class="px-8 py-4 bg-[#c9a227] text-[#0f2942] font-bold uppercase tracking-wider text-sm hover:bg-[#dbb732] transition-all"
						>
							{m.home_hero_button_products()}
						</a>
						<a 
							href="/contacts" 
							class="px-8 py-4 border-2 border-white/30 text-white font-bold uppercase tracking-wider text-sm hover:border-[#c9a227] hover:text-[#c9a227] transition-all"
						>
							{m.home_hero_button_contact()}
						</a>
					</div>
				</div>
			</div>
		</div>
	{/each}

	<!-- Slide Indicators -->
	<div class="absolute bottom-12 left-0 right-0">
		<div class="container mx-auto px-4">
			<div class="flex items-center gap-3">
				{#each slides as _, index}
					<button
						onclick={() => goToSlide(index)}
						class="group flex items-center gap-2"
						aria-label="Go to slide {index + 1}"
					>
						<span class="text-sm font-mono {currentSlide === index ? 'text-[#c9a227]' : 'text-gray-500'}">
							0{index + 1}
						</span>
						<span class="w-8 h-[2px] {currentSlide === index ? 'bg-[#c9a227] w-12' : 'bg-gray-600'} transition-all"></span>
					</button>
				{/each}
			</div>
		</div>
	</div>
</div>
