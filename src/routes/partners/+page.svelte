<svelte:head>
	<title>Our Partners - InterTransService</title>
	<meta name="description" content="InterTransService partners with leading construction equipment manufacturers and logistics providers worldwide." />
</svelte:head>

<div class="bg-gradient-to-br from-blue-600 to-blue-800 text-white py-20">
	<div class="container mx-auto px-4">
		<h1 class="text-4xl md:text-5xl font-bold mb-4">Our Partners</h1>
		<p class="text-xl text-blue-100">Building Success Together</p>
	</div>
</div>

<section class="py-16">
	<div class="container mx-auto px-4">
		<div class="max-w-4xl mx-auto text-center mb-16">
			<h2 class="text-3xl font-bold text-gray-900 mb-6">Strategic Partnerships</h2>
			<p class="text-lg text-gray-600 leading-relaxed">
				We collaborate with world-leading construction equipment manufacturers, logistics 
				providers, and technology partners to deliver comprehensive solutions to our clients. 
				Our partnerships enable us to offer competitive pricing, latest equipment, and reliable 
				service across borders.
			</p>
		</div>

		<div class="grid grid-cols-2 md:grid-cols-4 gap-8 mb-16">
			{#each Array(8) as _, i}
				<div class="bg-white border border-gray-200 rounded-lg p-6 flex items-center justify-center hover:shadow-lg transition-shadow aspect-square">
					<div class="text-center">
						<div class="text-4xl mb-2">🏢</div>
						<p class="text-sm text-gray-500">Partner {i + 1}</p>
					</div>
				</div>
			{/each}
		</div>

		<div class="bg-gray-50 rounded-lg p-12">
			<h2 class="text-3xl font-bold text-gray-900 mb-6 text-center">Partner Categories</h2>
			<div class="grid grid-cols-1 md:grid-cols-3 gap-8">
				<div class="text-center">
					<div class="bg-blue-100 rounded-full w-16 h-16 flex items-center justify-center mx-auto mb-4">
						<span class="text-2xl">🏗️</span>
					</div>
					<h3 class="text-xl font-bold text-gray-900 mb-3">Equipment Manufacturers</h3>
					<p class="text-gray-600">Leading global brands of construction and heavy machinery</p>
				</div>
				<div class="text-center">
					<div class="bg-blue-100 rounded-full w-16 h-16 flex items-center justify-center mx-auto mb-4">
						<span class="text-2xl">🚛</span>
					</div>
					<h3 class="text-xl font-bold text-gray-900 mb-3">Logistics Providers</h3>
					<p class="text-gray-600">International shipping and freight forwarding companies</p>
				</div>
				<div class="text-center">
					<div class="bg-blue-100 rounded-full w-16 h-16 flex items-center justify-center mx-auto mb-4">
						<span class="text-2xl">🔧</span>
					</div>
					<h3 class="text-xl font-bold text-gray-900 mb-3">Service Partners</h3>
					<p class="text-gray-600">Technical support, maintenance, and spare parts suppliers</p>
				</div>
			</div>
		</div>

		<div class="mt-16 text-center">
			<h2 class="text-3xl font-bold text-gray-900 mb-4">Become a Partner</h2>
			<p class="text-lg text-gray-600 mb-8 max-w-2xl mx-auto">
				Interested in partnering with us? We're always looking to expand our network 
				of quality suppliers and service providers.
			</p>
			<a href="/contacts" class="inline-block bg-blue-600 text-white px-8 py-3 rounded-md font-semibold hover:bg-blue-700 transition-colors">
				Contact Us
			</a>
		</div>
	</div>
</section>

