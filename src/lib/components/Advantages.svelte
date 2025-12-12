<script lang="ts">
	interface Advantage {
		icon: string;
		title: string;
		description: string;
	}

	const advantages: Advantage[] = [
		{
			icon: '👥',
			title: 'Experienced Team',
			description: 'Expert professionals with over 10 years of experience in machinery logistics and international shipping operations.'
		},
		{
			icon: '⭐',
			title: 'Premium Quality',
			description: 'Rigorous quality control at every stage ensures your construction machinery arrives in perfect condition.'
		},
		{
			icon: '🚚',
			title: 'Modern Fleet',
			description: 'State-of-the-art transportation equipment and handling systems designed for heavy machinery.'
		},
		{
			icon: '📋',
			title: 'Full Compliance',
			description: 'All necessary certifications and insurance coverage for safe international machinery transportation.'
		}
	];
</script>

<section class="py-16 bg-gray-50">
	<div class="container mx-auto px-4">
		<div class="text-center mb-12">
			<h2 class="text-4xl font-bold text-gray-900 mb-4">Welcome</h2>
			<p class="text-xl text-gray-600">Our Advantages</p>
		</div>

		<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
			{#each advantages as advantage}
				<div class="bg-white p-8 rounded-lg shadow-md hover:shadow-xl transition-shadow text-center">
					<div class="text-5xl mb-4">{advantage.icon}</div>
					<h3 class="text-xl font-bold text-gray-900 mb-3">{advantage.title}</h3>
					<p class="text-gray-600 leading-relaxed">{advantage.description}</p>
				</div>
			{/each}
		</div>
	</div>
</section>

