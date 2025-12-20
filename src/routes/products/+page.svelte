<script lang="ts">
	import { getAllProducts, getProductCapacity, getProductMaxHeight } from '$lib/utils/products';
	import * as m from '$lib/paraglide/messages';

	const products = getAllProducts();
</script>

<svelte:head>
	<title>{m.products_page_title()} - InterTransService</title>
	<meta name="description" content={m.products_meta_description()} />
</svelte:head>

<!-- Page Header -->
<div class="bg-[#0f2942] py-20 relative overflow-hidden">
	<div class="absolute inset-0 pattern-overlay opacity-30"></div>
	<div class="container mx-auto px-4 relative">
		<div class="flex items-center gap-4 mb-4">
			<div class="w-16 h-[2px] bg-[#c9a227]"></div>
			<span class="text-[#c9a227] text-sm font-semibold tracking-[0.2em] uppercase">{m.products_page_subtitle()}</span>
		</div>
		<h1 class="text-4xl md:text-6xl font-bold text-white">{m.products_page_title()}</h1>
		<p class="text-xl text-gray-300 mt-4 max-w-2xl">{m.products_page_description()}</p>
	</div>
</div>

<!-- Products Grid -->
<section class="py-20 bg-gray-100">
	<div class="container mx-auto px-4">
		<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-2 gap-8">
			{#each products as product}
				<a href="/products/{product.slug}" class="group">
					<div class="card-industrial bg-white h-full overflow-hidden">
						<!-- Image -->
						<div class="relative h-64 overflow-hidden bg-gray-200">
							<img 
								src={product.image} 
								alt={product.name}
								class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500"
							/>
							<div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent"></div>
							<div class="absolute bottom-4 left-4 right-4">
								<div class="text-[#c9a227] text-sm font-semibold mb-1">{product.type}</div>
								<h2 class="text-2xl font-bold text-white">{product.name}</h2>
							</div>
						</div>
						
						<!-- Content -->
						<div class="p-8">
							<p class="text-gray-600 mb-6 leading-relaxed">{product.shortDescription}</p>
							
			<!-- Key Specs -->
			<div class="grid grid-cols-2 gap-4 mb-6 pb-6 border-b border-gray-200">
				<div>
					<div class="text-xs text-gray-500 uppercase tracking-wide mb-1">{m.products_card_capacity_label()}</div>
					<div class="text-lg font-bold text-[#0f2942]">
						{getProductCapacity(product)}
					</div>
				</div>
				<div>
					<div class="text-xs text-gray-500 uppercase tracking-wide mb-1">{m.products_card_height_label()}</div>
					<div class="text-lg font-bold text-[#0f2942]">
						{getProductMaxHeight(product)}
					</div>
				</div>
			</div>							<!-- Features Preview -->
							<ul class="space-y-2 mb-6">
								{#each product.features.slice(0, 3) as feature}
									<li class="flex items-start gap-2 text-sm text-gray-700">
										<svg class="w-4 h-4 text-[#c9a227] mt-0.5 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
											<path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
										</svg>
										<span>{feature}</span>
									</li>
								{/each}
							</ul>
							
							<!-- CTA -->
							<div class="flex items-center gap-2 text-[#c9a227] font-semibold group-hover:gap-4 transition-all">
								<span>{m.products_view_details()}</span>
								<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
									<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3"/>
								</svg>
							</div>
						</div>
					</div>
				</a>
			{/each}
		</div>
	</div>
</section>

<!-- CTA Section -->
<section class="py-20 bg-[#0f2942] relative overflow-hidden">
	<div class="absolute inset-0 pattern-overlay opacity-30"></div>
	<div class="container mx-auto px-4 relative text-center">
		<h2 class="text-3xl md:text-4xl font-bold text-white mb-6">{m.products_cta_title()}</h2>
		<p class="text-xl text-gray-300 mb-8 max-w-2xl mx-auto">
			{m.products_cta_description()}
		</p>
		<a 
			href="/contacts" 
			class="inline-flex items-center gap-2 px-8 py-4 bg-[#c9a227] text-[#0f2942] font-bold uppercase tracking-wider text-sm hover:bg-[#dbb732] transition-colors"
		>
			{m.products_cta_button()}
			<svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
				<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3"/>
			</svg>
		</a>
	</div>
</section>
