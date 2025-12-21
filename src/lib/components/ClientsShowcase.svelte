<script lang="ts">
	import * as m from '$lib/paraglide/messages';

	interface Client {
		name: string;
		url: string;
		logo: string;
		description: string;
	}

	const clients: Client[] = [
		{
			name: m.client_kbm_name(),
			url: "https://www.kbm.kz",
			logo: "/clients/logo_kbm.png",
			description: m.client_kbm_description()
		},
		{
			name: m.client_anpz_name(),
			url: "https://www.anpz.kz",
			logo: "/clients/logo_anpz.jpg", 
			description: m.client_anpz_description()
		},
		{
			name: m.client_caspibitum_name(),
			url: "https://www.caspibitum.kz",
			logo: "/clients/logo_caspibitum.png",
			description: m.client_caspibitum_description()
		},
		{
			name: m.client_tengiz_name(),
			url: "https://www.tengizchevroil.com",
			logo: "/clients/logo_tengiz.png",
			description: m.client_tengiz_description()
		}
	];
</script>

<section class="py-20 bg-gray-100">
	<div class="container mx-auto px-4">
		<!-- Section header -->
		<div class="mb-16 text-center">
			<span class="text-[#c9a227] text-sm font-semibold tracking-[0.2em] uppercase">{m.clients_showcase_subtitle()}</span>
			<h2 class="text-4xl md:text-5xl font-bold text-[#0f2942] mt-2 section-title">{m.clients_showcase_title()}</h2>
			<p class="text-xl text-gray-600 mt-6 max-w-3xl mx-auto">
				{m.clients_showcase_description()}
			</p>
		</div>

		<!-- Clients grid -->
		<div class="grid grid-cols-2 md:grid-cols-4 gap-8 mb-12">
			{#each clients as client}
				<a 
					href={client.url} 
					target="_blank" 
					rel="noopener noreferrer"
					class="group bg-white p-8 card-industrial flex flex-col items-center justify-center min-h-[200px] hover:shadow-xl transition-all duration-300"
				>
					<div class="w-full h-20 mb-4 flex items-center justify-center">
						<img 
							src={client.logo} 
							alt={client.name}
							class="max-w-full max-h-full object-contain filter grayscale group-hover:grayscale-0 transition-all duration-300"
							on:error={(e) => {
								// Fallback if image doesn't exist
								e.currentTarget.style.display = 'none';
								const parent = e.currentTarget.parentElement;
								if (parent) {
									parent.innerHTML = `<div class="w-16 h-16 bg-[#0f2942] flex items-center justify-center">
										<svg class="w-8 h-8 text-[#c9a227]" fill="currentColor" viewBox="0 0 24 24">
											<path d="M12 7V3H2v18h20V7H12zM6 19H4v-2h2v2zm0-4H4v-2h2v2zm0-4H4V9h2v2zm0-4H4V5h2v2zm4 12H8v-2h2v2zm0-4H8v-2h2v2zm0-4H8V9h2v2zm0-4H8V5h2v2zm10 12h-8v-2h2v-2h-2v-2h2v-2h-2V9h8v10zm-2-8h-2v2h2v-2zm0 4h-2v2h2v-2z"/>
										</svg>
									</div>`;
								}
							}}
						/>
					</div>
					<h3 class="text-center font-bold text-[#0f2942] group-hover:text-[#c9a227] transition-colors text-sm mb-2">
						{client.name}
					</h3>
					<p class="text-center text-gray-500 text-xs leading-tight">
						{client.description}
					</p>
					<svg class="w-4 h-4 text-gray-400 group-hover:text-[#c9a227] mt-3 group-hover:translate-x-1 transition-all" fill="none" stroke="currentColor" viewBox="0 0 24 24">
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"/>
					</svg>
				</a>
			{/each}
		</div>

		<!-- Additional info -->
		<div class="text-center">
			<p class="text-gray-600 mb-6 max-w-2xl mx-auto">
				{m.clients_showcase_additional_info()}
			</p>
			<a 
				href="/contacts" 
				class="inline-flex items-center gap-2 px-8 py-4 bg-[#0f2942] text-white font-bold uppercase tracking-wider text-sm hover:bg-[#1a365d] transition-colors"
			>
				{m.clients_showcase_button()}
				<svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
					<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3"/>
				</svg>
			</a>
		</div>
	</div>
</section>