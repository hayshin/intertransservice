<script lang="ts">
	interface Product {
		title: string;
		description: string;
		icon: string;
	}

	const products: Product[] = [
		{
			title: 'Heavy Machinery Transport',
			description: 'Specialized transportation services for excavators, bulldozers, cranes, and other heavy construction equipment.',
			icon: '🏗️'
		},
		{
			title: 'International Shipping',
			description: 'Cross-border logistics solutions with customs clearance and documentation handling.',
			icon: '🌍'
		},
		{
			title: 'Equipment Installation',
			description: 'Professional on-site installation and commissioning services for construction machinery.',
			icon: '🔧'
		},
		{
			title: 'Warehousing Solutions',
			description: 'Secure storage facilities designed for construction equipment and spare parts.',
			icon: '📦'
		},
		{
			title: 'Parts Supply',
			description: 'Comprehensive spare parts sourcing and delivery for all major machinery brands.',
			icon: '⚙️'
		},
		{
			title: 'Technical Support',
			description: 'Expert consultation and technical support throughout the equipment lifecycle.',
			icon: '💼'
		}
	];
</script>

<section class="py-16 bg-white">
	<div class="container mx-auto px-4">
		<div class="text-center mb-12">
			<h2 class="text-4xl font-bold text-gray-900 mb-4">What We Offer</h2>
			<p class="text-xl text-gray-600">Our Services</p>
		</div>

		<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
			{#each products as product}
				<div class="border border-gray-200 rounded-lg p-6 hover:shadow-lg transition-shadow">
					<div class="text-4xl mb-4">{product.icon}</div>
					<h3 class="text-xl font-bold text-gray-900 mb-3">{product.title}</h3>
					<p class="text-gray-600 leading-relaxed">{product.description}</p>
				</div>
			{/each}
		</div>

		<div class="text-center mt-12">
			<a 
				href="/products" 
				class="inline-block bg-blue-600 text-white px-8 py-3 rounded-md font-semibold hover:bg-blue-700 transition-colors"
			>
				View All Services
			</a>
		</div>
	</div>
</section>

