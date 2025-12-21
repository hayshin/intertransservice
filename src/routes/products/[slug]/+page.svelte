<script lang="ts">
	import type { PageData } from './$types';
	import * as m from '$lib/paraglide/messages';

	let { data }: { data: PageData } = $props();
	const product = $derived.by(() => data.product);

	function getWhatsAppURL() {
		const message = m.products_whatsapp_message({
			productName: product.name,
			productType: product.type
		});
		const phoneNumber = "+77019134104"; // Replace with your WhatsApp business number
		return `https://wa.me/${phoneNumber}?text=${encodeURIComponent(message)}`;
	}
</script>

<svelte:head>
	<title>{product.name} - {m.products_page_title()} - InterTransService</title>
	<meta name="description" content={product.shortDescription} />
</svelte:head>

<!-- Back Button -->
<div class="bg-gray-100 py-4 border-b border-gray-200">
	<div class="container mx-auto px-4">
		<a 
			href="/products" 
			class="inline-flex items-center gap-2 text-[#0f2942] hover:text-[#c9a227] transition-colors font-medium"
		>
			<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
				<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
			</svg>
			{m.products_back_to_list()}
		</a>
	</div>
</div>

<!-- Hero Section -->
<div class="bg-[#0f2942] py-16 relative overflow-hidden">
	<div class="absolute inset-0 pattern-overlay opacity-30"></div>
	<div class="container mx-auto px-4 relative">
		<div class="flex items-center gap-4 mb-4">
			<div class="w-16 h-[2px] bg-[#c9a227]"></div>
			<span class="text-[#c9a227] text-sm font-semibold tracking-[0.2em] uppercase">{product.type}</span>
		</div>
		<h1 class="text-4xl md:text-6xl font-bold text-white mb-4">{product.name}</h1>
		<p class="text-xl text-gray-300 max-w-3xl">{product.shortDescription}</p>
	</div>
</div>

<!-- Main Content -->
<section class="py-16 bg-white">
	<div class="container mx-auto px-4">
		<div class="grid grid-cols-1 lg:grid-cols-2 gap-12 items-start">
			<!-- Image -->
			<div class="sticky top-8">
				<div class="relative aspect-[4/3] overflow-hidden rounded-lg bg-gray-200 shadow-xl">
					<img 
						src={product.image} 
						alt={product.name}
						class="w-full h-full object-cover"
					/>
				</div>
				
				<!-- CTA Button -->
				<div class="mt-6">
					<a 
						href={getWhatsAppURL()}
						target="_blank"
						rel="noopener noreferrer"
						class="w-full px-6 py-4 bg-[#c9a227] text-[#0f2942] font-bold uppercase tracking-wider text-sm hover:bg-[#dbb732] transition-colors text-center block"
					>
						{m.products_request_quote()}
					</a>
				</div>
			</div>
			
			<!-- Content -->
			<div>
				<!-- Features -->
				<div class="mb-12">
					<h2 class="text-3xl font-bold text-[#0f2942] mb-6 flex items-center gap-3">
						<div class="w-12 h-1 bg-[#c9a227]"></div>
						{m.products_features()}
					</h2>
					<ul class="space-y-4">
						{#each product.features as feature}
							<li class="flex items-start gap-4">
								<div class="w-6 h-6 bg-[#c9a227] rounded-full flex items-center justify-center flex-shrink-0 mt-0.5">
									<svg class="w-4 h-4 text-white" fill="currentColor" viewBox="0 0 20 20">
										<path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
									</svg>
								</div>
								<span class="text-gray-700 text-lg leading-relaxed">{feature}</span>
							</li>
						{/each}
					</ul>
				</div>
				
				<!-- Full Description -->
				<div class="mb-12">
					<h2 class="text-3xl font-bold text-[#0f2942] mb-6 flex items-center gap-3">
						<div class="w-12 h-1 bg-[#c9a227]"></div>
						{m.products_description()}
					</h2>
					<div class="prose prose-lg max-w-none text-gray-700 leading-relaxed whitespace-pre-line">
						{product.fullDescription}
					</div>
				</div>
				
				<!-- Specifications -->
				<div>
					<h2 class="text-3xl font-bold text-[#0f2942] mb-6 flex items-center gap-3">
						<div class="w-12 h-1 bg-[#c9a227]"></div>
						{m.products_specs()}
					</h2>
					<div class="bg-gray-50 rounded-lg p-6">
						<dl class="grid grid-cols-1 md:grid-cols-2 gap-6">
							{#each product.specs as spec}
								<div class="border-b border-gray-200 pb-4 last:border-0 last:pb-0">
									<dt class="text-sm text-gray-500 uppercase tracking-wide mb-2">{spec.key}</dt>
									<dd class="text-xl font-bold text-[#0f2942]">{spec.value}</dd>
								</div>
							{/each}
						</dl>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<!-- Related Products / CTA -->
<section class="py-20 bg-gray-100">
	<div class="container mx-auto px-4 text-center">
		<h2 class="text-3xl md:text-4xl font-bold text-[#0f2942] mb-6">{m.products_cta_title()}</h2>
		<p class="text-xl text-gray-600 mb-8 max-w-2xl mx-auto">
			{m.products_cta_description()}
		</p>
		<a 
			href="/contacts" 
			class="inline-flex items-center gap-2 px-8 py-4 bg-[#0f2942] text-white font-bold uppercase tracking-wider text-sm hover:bg-[#1a365d] transition-colors"
		>
			{m.products_cta_button()}
			<svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
				<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3"/>
			</svg>
		</a>
	</div>
</section>

