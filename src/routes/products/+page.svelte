<script lang="ts">
	interface Service {
		title: string;
		description: string;
		features: string[];
		icon: string;
	}

	const services: Service[] = [
		{
			title: 'Heavy Machinery Transport',
			description: 'Specialized transportation services for all types of construction equipment',
			features: [
				'Excavators and bulldozers',
				'Tower cranes and mobile cranes',
				'Concrete pumps and mixers',
				'Road construction equipment'
			],
			icon: '🏗️'
		},
		{
			title: 'International Shipping',
			description: 'Cross-border logistics with full documentation support',
			features: [
				'Customs clearance assistance',
				'International documentation',
				'Multi-modal transportation',
				'Real-time tracking'
			],
			icon: '🌍'
		},
		{
			title: 'Equipment Installation',
			description: 'Professional on-site installation and setup services',
			features: [
				'Technical commissioning',
				'Safety inspection',
				'Operator training',
				'Performance testing'
			],
			icon: '🔧'
		},
		{
			title: 'Warehousing Solutions',
			description: 'Secure storage facilities for equipment and parts',
			features: [
				'Climate-controlled storage',
				'24/7 security monitoring',
				'Inventory management',
				'Short and long-term options'
			],
			icon: '📦'
		},
		{
			title: 'Parts Supply',
			description: 'Comprehensive spare parts sourcing and delivery',
			features: [
				'Original manufacturer parts',
				'Fast delivery worldwide',
				'Parts warranty',
				'Technical consultation'
			],
			icon: '⚙️'
		},
		{
			title: 'Technical Support',
			description: 'Expert consultation throughout equipment lifecycle',
			features: [
				'Equipment selection advice',
				'Maintenance planning',
				'Technical troubleshooting',
				'Upgrade recommendations'
			],
			icon: '💼'
		}
	];
</script>

<svelte:head>
	<title>Our Services - InterTransService</title>
	<meta name="description" content="Comprehensive construction machinery logistics services including transport, installation, warehousing, and technical support." />
</svelte:head>

<div class="bg-gradient-to-br from-blue-600 to-blue-800 text-white py-20">
	<div class="container mx-auto px-4">
		<h1 class="text-4xl md:text-5xl font-bold mb-4">Our Services</h1>
		<p class="text-xl text-blue-100">Comprehensive Solutions for Construction Machinery</p>
	</div>
</div>

<section class="py-16">
	<div class="container mx-auto px-4">
		<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
			{#each services as service}
				<div class="bg-white border border-gray-200 rounded-lg p-6 hover:shadow-xl transition-shadow">
					<div class="text-5xl mb-4">{service.icon}</div>
					<h2 class="text-2xl font-bold text-gray-900 mb-3">{service.title}</h2>
					<p class="text-gray-600 mb-4">{service.description}</p>
					<ul class="space-y-2">
						{#each service.features as feature}
							<li class="flex items-start">
								<svg class="w-5 h-5 text-green-500 mr-2 mt-0.5 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
									<path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
								</svg>
								<span class="text-gray-700">{feature}</span>
							</li>
						{/each}
					</ul>
				</div>
			{/each}
		</div>

		<div class="mt-16 bg-blue-50 rounded-lg p-8 text-center">
			<h2 class="text-3xl font-bold text-gray-900 mb-4">Need a Custom Solution?</h2>
			<p class="text-lg text-gray-600 mb-6">We understand that every project is unique. Let us create a tailored logistics solution for your needs.</p>
			<a href="/contacts" class="inline-block bg-blue-600 text-white px-8 py-3 rounded-md font-semibold hover:bg-blue-700 transition-colors">
				Contact Us
			</a>
		</div>
	</div>
</section>

