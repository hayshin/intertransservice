<script lang="ts">
	interface Leader {
		name: string;
		position: string;
		initials: string;
	}

	const leaders: Leader[] = [
		{
			name: 'Alexander Petrov',
			position: 'Managing Director',
			initials: 'AP'
		},
		{
			name: 'Maria Ivanova',
			position: 'Chief Operations Officer',
			initials: 'MI'
		},
		{
			name: 'Sergey Kozlov',
			position: 'Logistics Director',
			initials: 'SK'
		},
		{
			name: 'Elena Volkova',
			position: 'Finance Director',
			initials: 'EV'
		}
	];
</script>

<section class="py-16 bg-gray-50">
	<div class="container mx-auto px-4">
		<div class="text-center mb-12">
			<h2 class="text-4xl font-bold text-gray-900 mb-4">Leadership</h2>
			<p class="text-xl text-gray-600">Our Management Team</p>
		</div>

		<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
			{#each leaders as leader}
				<div class="bg-white rounded-lg shadow-md p-6 text-center hover:shadow-xl transition-shadow">
					<!-- Avatar placeholder with initials -->
					<div class="w-32 h-32 bg-gradient-to-br from-blue-500 to-blue-600 rounded-full mx-auto mb-4 flex items-center justify-center">
						<span class="text-3xl font-bold text-white">{leader.initials}</span>
					</div>
					<h3 class="text-xl font-bold text-gray-900 mb-2">{leader.name}</h3>
					<p class="text-gray-600">{leader.position}</p>
				</div>
			{/each}
		</div>
	</div>
</section>

