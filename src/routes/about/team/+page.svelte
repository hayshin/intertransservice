<script lang="ts">
	import LeadershipTeam from '$lib/components/LeadershipTeam.svelte';
</script>

<svelte:head>
	<title>Our Team - InterTransService</title>
	<meta name="description" content="Meet the leadership team at InterTransService, experienced professionals dedicated to excellence in construction machinery logistics." />
</svelte:head>

<div class="bg-gradient-to-br from-blue-600 to-blue-800 text-white py-20">
	<div class="container mx-auto px-4">
		<h1 class="text-4xl md:text-5xl font-bold mb-4">Our Team</h1>
		<p class="text-xl text-blue-100">Meet the People Behind Our Success</p>
	</div>
</div>

<section class="py-16">
	<div class="container mx-auto px-4">
		<div class="max-w-4xl mx-auto text-center mb-12">
			<p class="text-lg text-gray-600 leading-relaxed">
				Our team is comprised of experienced professionals who are passionate about 
				delivering exceptional service. With expertise spanning logistics, engineering, 
				and customer service, we work together to ensure your success.
			</p>
		</div>
	</div>
</section>

<LeadershipTeam />

<section class="py-16 bg-white">
	<div class="container mx-auto px-4">
		<div class="bg-blue-600 rounded-lg p-12 text-center text-white">
			<h2 class="text-3xl font-bold mb-4">Join Our Team</h2>
			<p class="text-xl mb-8 text-blue-100">We're always looking for talented individuals to join our growing team.</p>
			<a href="/careers" class="inline-block bg-white text-blue-600 px-8 py-3 rounded-md font-semibold hover:bg-gray-100 transition-colors">
				View Open Positions
			</a>
		</div>
	</div>
</section>

