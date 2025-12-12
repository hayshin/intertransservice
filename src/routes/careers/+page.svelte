<script lang="ts">
	interface Position {
		title: string;
		department: string;
		location: string;
		type: string;
		description: string;
	}

	const openPositions: Position[] = [
		{
			title: 'Logistics Coordinator',
			department: 'Operations',
			location: 'Almaty, Kazakhstan',
			type: 'Full-time',
			description: 'Manage transportation schedules, coordinate with carriers, and ensure timely delivery of construction machinery.'
		},
		{
			title: 'Technical Support Engineer',
			department: 'Technical',
			location: 'Almaty, Kazakhstan',
			type: 'Full-time',
			description: 'Provide technical consultation and support for construction equipment installation and maintenance.'
		},
		{
			title: 'Sales Manager',
			department: 'Sales',
			location: 'Almaty, Kazakhstan',
			type: 'Full-time',
			description: 'Develop new business relationships and manage existing client accounts in the construction machinery sector.'
		}
	];

	let formData = $state({
		name: '',
		email: '',
		phone: '',
		position: '',
		resume: null as File | null
	});

	let submitted = $state(false);

	function handleSubmit(event: Event) {
		event.preventDefault();
		console.log('Resume submitted:', formData);
		submitted = true;
		setTimeout(() => {
			submitted = false;
			formData = { name: '', email: '', phone: '', position: '', resume: null };
		}, 3000);
	}

	function handleFileChange(event: Event) {
		const target = event.target as HTMLInputElement;
		if (target.files && target.files.length > 0) {
			formData.resume = target.files[0];
		}
	}
</script>

<svelte:head>
	<title>Careers - InterTransService</title>
	<meta name="description" content="Join the InterTransService team. Explore career opportunities in construction machinery logistics." />
</svelte:head>

<div class="bg-gradient-to-br from-blue-600 to-blue-800 text-white py-20">
	<div class="container mx-auto px-4">
		<h1 class="text-4xl md:text-5xl font-bold mb-4">Careers</h1>
		<p class="text-xl text-blue-100">Join Our Growing Team</p>
	</div>
</div>

<section class="py-16">
	<div class="container mx-auto px-4">
		<div class="max-w-4xl mx-auto text-center mb-12">
			<h2 class="text-3xl font-bold text-gray-900 mb-4">Why Work With Us?</h2>
			<p class="text-lg text-gray-600 leading-relaxed">
				At InterTransService, we value our employees and invest in their growth. 
				We offer competitive compensation, professional development opportunities, 
				and a collaborative work environment.
			</p>
		</div>

		<div class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-16">
			<div class="bg-white border border-gray-200 rounded-lg p-6 text-center">
				<div class="text-4xl mb-4">📈</div>
				<h3 class="text-xl font-bold text-gray-900 mb-2">Career Growth</h3>
				<p class="text-gray-600">Clear career paths and opportunities for advancement</p>
			</div>
			<div class="bg-white border border-gray-200 rounded-lg p-6 text-center">
				<div class="text-4xl mb-4">🎓</div>
				<h3 class="text-xl font-bold text-gray-900 mb-2">Training</h3>
				<p class="text-gray-600">Continuous learning and professional development programs</p>
			</div>
			<div class="bg-white border border-gray-200 rounded-lg p-6 text-center">
				<div class="text-4xl mb-4">⚖️</div>
				<h3 class="text-xl font-bold text-gray-900 mb-2">Work-Life Balance</h3>
				<p class="text-gray-600">Flexible working arrangements and competitive benefits</p>
			</div>
		</div>

		{#if openPositions.length > 0}
			<div class="mb-16">
				<h2 class="text-3xl font-bold text-gray-900 mb-8 text-center">Open Positions</h2>
				<div class="space-y-4 max-w-4xl mx-auto">
					{#each openPositions as position}
						<div class="bg-white border border-gray-200 rounded-lg p-6 hover:shadow-lg transition-shadow">
							<div class="flex flex-wrap items-start justify-between gap-4">
								<div class="flex-grow">
									<h3 class="text-xl font-bold text-gray-900 mb-2">{position.title}</h3>
									<div class="flex flex-wrap gap-3 mb-3 text-sm">
										<span class="text-gray-600">📂 {position.department}</span>
										<span class="text-gray-600">📍 {position.location}</span>
										<span class="text-gray-600">⏰ {position.type}</span>
									</div>
									<p class="text-gray-600">{position.description}</p>
								</div>
								<a href="#apply" class="bg-blue-600 text-white px-6 py-2 rounded-md font-semibold hover:bg-blue-700 transition-colors whitespace-nowrap">
									Apply Now
								</a>
							</div>
						</div>
					{/each}
				</div>
			</div>
		{/if}

		<div id="apply" class="bg-gray-50 rounded-lg p-8 max-w-2xl mx-auto">
			<h2 class="text-2xl font-bold text-gray-900 mb-6 text-center">Submit Your Resume</h2>
			
			{#if submitted}
				<div class="bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded-md mb-4">
					Thank you for your application! We'll review your resume and get back to you soon.
				</div>
			{/if}

			<form onsubmit={handleSubmit} class="space-y-4">
				<div>
					<label for="name" class="block text-sm font-medium text-gray-700 mb-1">Full Name *</label>
					<input 
						type="text" 
						id="name" 
						bind:value={formData.name}
						required 
						class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-transparent"
					/>
				</div>

				<div>
					<label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email *</label>
					<input 
						type="email" 
						id="email" 
						bind:value={formData.email}
						required 
						class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-transparent"
					/>
				</div>

				<div>
					<label for="phone" class="block text-sm font-medium text-gray-700 mb-1">Phone *</label>
					<input 
						type="tel" 
						id="phone" 
						bind:value={formData.phone}
						required 
						class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-transparent"
					/>
				</div>

				<div>
					<label for="position" class="block text-sm font-medium text-gray-700 mb-1">Position of Interest *</label>
					<select 
						id="position" 
						bind:value={formData.position}
						required 
						class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-transparent"
					>
						<option value="">Select a position</option>
						{#each openPositions as position}
							<option value={position.title}>{position.title}</option>
						{/each}
						<option value="other">Other / General Application</option>
					</select>
				</div>

				<div>
					<label for="resume" class="block text-sm font-medium text-gray-700 mb-1">Resume/CV *</label>
					<input 
						type="file" 
						id="resume" 
						onchange={handleFileChange}
						accept=".pdf,.doc,.docx"
						required 
						class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-transparent"
					/>
					<p class="text-sm text-gray-500 mt-1">Accepted formats: PDF, DOC, DOCX (Max 5MB)</p>
				</div>

				<button 
					type="submit" 
					class="w-full bg-blue-600 text-white py-3 rounded-md font-semibold hover:bg-blue-700 transition-colors"
				>
					Submit Application
				</button>
			</form>
		</div>
	</div>
</section>

