<script lang="ts">
	import * as m from '$lib/paraglide/messages';
	import ClientsShowcase from '$lib/components/ClientsShowcase.svelte';
</script>

<svelte:head>
	<title>{m.partners_meta_title()}</title>
	<meta name="description" content={m.partners_meta_description()} />
</svelte:head>

<!-- Page Header -->
<div class="bg-[#0f2942] py-20 relative overflow-hidden">
	<div class="absolute inset-0 pattern-overlay opacity-30"></div>
	<div class="container mx-auto px-4 relative">
		<div class="flex items-center gap-4 mb-4">
			<div class="w-16 h-[2px] bg-[#c9a227]"></div>
			<span class="text-[#c9a227] text-sm font-semibold tracking-[0.2em] uppercase">{m.partners_page_subtitle()}</span>
		</div>
		<h1 class="text-4xl md:text-6xl font-bold text-white">{m.partners_page_title()}</h1>
	</div>
</div>

<!-- Introduction -->
<section class="py-20 bg-white">
	<div class="container mx-auto px-4">
		<div class="max-w-4xl mx-auto text-center">
			<h2 class="text-3xl font-bold text-[#0f2942] mb-6">{m.partners_intro_title()}</h2>
			<p class="text-xl text-gray-600 leading-relaxed">
				{m.partners_intro_description()}
			</p>
		</div>
	</div>
</section>

<!-- Clients Showcase Component -->
<ClientsShowcase />

<!-- Client Categories -->
<section class="py-20 bg-white">
	<div class="container mx-auto px-4">
		<div class="mb-16 text-center">
			<span class="text-[#c9a227] text-sm font-semibold tracking-[0.2em] uppercase">{m.partners_categories_subtitle()}</span>
			<h2 class="text-4xl font-bold text-[#0f2942] mt-2">{m.partners_categories_title()}</h2>
		</div>
		
		<div class="grid grid-cols-1 md:grid-cols-3 gap-8">
			<div class="text-center">
				<div class="w-20 h-20 bg-[#0f2942] mx-auto mb-6 flex items-center justify-center">
					<svg class="w-10 h-10 text-[#c9a227]" fill="none" stroke="currentColor" viewBox="0 0 24 24">
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"/>
					</svg>
				</div>
				<h3 class="text-xl font-bold text-[#0f2942] mb-3">{m.partners_category1_title()}</h3>
				<p class="text-gray-600">{m.partners_category1_description()}</p>
			</div>
			
			<div class="text-center">
				<div class="w-20 h-20 bg-[#0f2942] mx-auto mb-6 flex items-center justify-center">
					<svg class="w-10 h-10 text-[#c9a227]" fill="none" stroke="currentColor" viewBox="0 0 24 24">
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"/>
					</svg>
				</div>
				<h3 class="text-xl font-bold text-[#0f2942] mb-3">{m.partners_category2_title()}</h3>
				<p class="text-gray-600">{m.partners_category2_description()}</p>
			</div>
			
			<div class="text-center">
				<div class="w-20 h-20 bg-[#0f2942] mx-auto mb-6 flex items-center justify-center">
					<svg class="w-10 h-10 text-[#c9a227]" fill="none" stroke="currentColor" viewBox="0 0 24 24">
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"/>
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
					</svg>
				</div>
				<h3 class="text-xl font-bold text-[#0f2942] mb-3">{m.partners_category3_title()}</h3>
				<p class="text-gray-600">{m.partners_category3_description()}</p>
			</div>
		</div>
	</div>
</section>

<!-- CTA Section -->
<section class="py-20 bg-[#0f2942] relative overflow-hidden">
	<div class="absolute inset-0 pattern-overlay opacity-30"></div>
	<div class="container mx-auto px-4 relative text-center">
		<h2 class="text-3xl md:text-4xl font-bold text-white mb-6">{m.partners_cta_title()}</h2>
		<p class="text-xl text-gray-300 mb-8 max-w-2xl mx-auto">
			{m.partners_cta_description()}
		</p>
		<a 
			href="/contacts" 
			class="inline-flex items-center gap-2 px-8 py-4 bg-[#c9a227] text-[#0f2942] font-bold uppercase tracking-wider text-sm hover:bg-[#dbb732] transition-colors"
		>
			{m.partners_cta_button()}
			<svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
				<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3"/>
			</svg>
		</a>
	</div>
</section>
