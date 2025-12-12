<script lang="ts">
	interface Project {
		title: string;
		client: string;
		description: string;
		year: string;
		category: string;
	}

	const projects: Project[] = [
		{
			title: 'Major Highway Construction Equipment Supply',
			client: 'National Infrastructure Development',
			description: 'Complete logistics solution for delivering 25+ heavy construction machines including excavators, graders, and asphalt pavers for a 200km highway project.',
			year: '2024',
			category: 'Infrastructure'
		},
		{
			title: 'Mining Equipment Transportation',
			client: 'Kazakh Mining Corporation',
			description: 'International shipping and installation of large-scale mining equipment from Europe to Kazakhstan, including customs clearance and on-site commissioning.',
			year: '2023',
			category: 'Mining'
		},
		{
			title: 'Urban Development Machinery Package',
			client: 'Almaty City Development',
			description: 'Coordinated delivery of various construction machinery for multiple urban development sites, with warehousing and just-in-time delivery.',
			year: '2023',
			category: 'Urban Development'
		},
		{
			title: 'Oil & Gas Construction Support',
			client: 'Energy Sector Client',
			description: 'Specialized transportation of construction equipment to remote oil field locations, including route planning and permit management.',
			year: '2022',
			category: 'Energy'
		},
		{
			title: 'Railway Modernization Equipment',
			client: 'Kazakhstan Railways',
			description: 'Logistics management for railway construction equipment including track layers, ballast regulators, and maintenance vehicles.',
			year: '2022',
			category: 'Railway'
		},
		{
			title: 'Commercial Complex Construction',
			client: 'Private Development Group',
			description: 'Full-service package including tower cranes, concrete equipment, and material handling machinery for large commercial development.',
			year: '2021',
			category: 'Commercial'
		}
	];
</script>

<svelte:head>
	<title>Our Projects - InterTransService</title>
	<meta name="description" content="Explore successful construction machinery logistics projects completed by InterTransService across Kazakhstan and Central Asia." />
</svelte:head>

<div class="bg-gradient-to-br from-blue-600 to-blue-800 text-white py-20">
	<div class="container mx-auto px-4">
		<h1 class="text-4xl md:text-5xl font-bold mb-4">Our Projects</h1>
		<p class="text-xl text-blue-100">Successful Partnerships and Completed Projects</p>
	</div>
</div>

<section class="py-16">
	<div class="container mx-auto px-4">
		<div class="mb-12 text-center max-w-3xl mx-auto">
			<p class="text-lg text-gray-600">
				Over the years, we have successfully completed numerous projects across various sectors. 
				Each project showcases our commitment to excellence, reliability, and customer satisfaction.
			</p>
		</div>

		<div class="grid grid-cols-1 md:grid-cols-2 gap-8">
			{#each projects as project}
				<div class="bg-white border border-gray-200 rounded-lg p-6 hover:shadow-lg transition-shadow">
					<div class="flex items-start justify-between mb-4">
						<span class="bg-blue-100 text-blue-600 text-sm font-semibold px-3 py-1 rounded-full">
							{project.category}
						</span>
						<span class="text-gray-500 text-sm">{project.year}</span>
					</div>
					<h3 class="text-xl font-bold text-gray-900 mb-2">{project.title}</h3>
					<p class="text-blue-600 font-medium mb-3">{project.client}</p>
					<p class="text-gray-600 leading-relaxed">{project.description}</p>
				</div>
			{/each}
		</div>

		<div class="mt-16 bg-gradient-to-br from-blue-50 to-blue-100 rounded-lg p-8 text-center">
			<h2 class="text-3xl font-bold text-gray-900 mb-4">Have a Project in Mind?</h2>
			<p class="text-lg text-gray-600 mb-6">
				Let's discuss how we can support your construction machinery logistics needs.
			</p>
			<a href="/contacts" class="inline-block bg-blue-600 text-white px-8 py-3 rounded-md font-semibold hover:bg-blue-700 transition-colors">
				Start a Conversation
			</a>
		</div>
	</div>
</section>

