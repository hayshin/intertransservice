<script lang="ts">
	let formData = $state({
		name: '',
		email: '',
		phone: '',
		company: '',
		message: ''
	});

	let submitted = $state(false);

	function handleSubmit(event: Event) {
		event.preventDefault();
		// Here you would typically send the form data to a server
		console.log('Form submitted:', formData);
		submitted = true;
		
		// Reset form after 3 seconds
		setTimeout(() => {
			submitted = false;
			formData = { name: '', email: '', phone: '', company: '', message: '' };
		}, 3000);
	}
</script>

<svelte:head>
	<title>Contact Us - InterTransService</title>
	<meta name="description" content="Get in touch with InterTransService for construction machinery logistics solutions. We're here to help with your transportation needs." />
</svelte:head>

<div class="bg-gradient-to-br from-blue-600 to-blue-800 text-white py-20">
	<div class="container mx-auto px-4">
		<h1 class="text-4xl md:text-5xl font-bold mb-4">Contact Us</h1>
		<p class="text-xl text-blue-100">Get in Touch with Our Team</p>
	</div>
</div>

<section class="py-16">
	<div class="container mx-auto px-4">
		<div class="grid grid-cols-1 lg:grid-cols-2 gap-12">
			<!-- Contact Information -->
			<div>
				<h2 class="text-3xl font-bold text-gray-900 mb-6">Get In Touch</h2>
				<p class="text-gray-600 mb-8 leading-relaxed">
					We're here to help with all your construction machinery logistics needs. 
					Whether you need a quote, have questions about our services, or want to 
					discuss a custom solution, don't hesitate to reach out.
				</p>

				<div class="space-y-6">
					<div class="flex items-start">
						<div class="bg-blue-100 rounded-full p-3 mr-4">
							<svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
								<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"></path>
							</svg>
						</div>
						<div>
							<h3 class="font-semibold text-gray-900 mb-1">Phone</h3>
							<a href="tel:+77777777777" class="text-blue-600 hover:text-blue-700">+7 777 777 77 77</a>
						</div>
					</div>

					<div class="flex items-start">
						<div class="bg-blue-100 rounded-full p-3 mr-4">
							<svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
								<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path>
							</svg>
						</div>
						<div>
							<h3 class="font-semibold text-gray-900 mb-1">Email</h3>
							<a href="mailto:info@intertrans.kz" class="text-blue-600 hover:text-blue-700">info@intertrans.kz</a>
						</div>
					</div>

					<div class="flex items-start">
						<div class="bg-blue-100 rounded-full p-3 mr-4">
							<svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
								<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"></path>
								<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"></path>
							</svg>
						</div>
						<div>
							<h3 class="font-semibold text-gray-900 mb-1">Address</h3>
							<p class="text-gray-600">Republic of Kazakhstan<br>Almaty</p>
						</div>
					</div>

					<div class="flex items-start">
						<div class="bg-blue-100 rounded-full p-3 mr-4">
							<svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
								<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
							</svg>
						</div>
						<div>
							<h3 class="font-semibold text-gray-900 mb-1">Working Hours</h3>
							<p class="text-gray-600">Monday - Friday: 9:00 AM - 6:00 PM<br>Saturday: 10:00 AM - 2:00 PM</p>
						</div>
					</div>
				</div>
			</div>

			<!-- Contact Form -->
			<div class="bg-gray-50 rounded-lg p-8">
				<h2 class="text-2xl font-bold text-gray-900 mb-6">Send Us a Message</h2>
				
				{#if submitted}
					<div class="bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded-md mb-4">
						Thank you for your message! We'll get back to you soon.
					</div>
				{/if}

				<form onsubmit={handleSubmit} class="space-y-4">
					<div>
						<label for="name" class="block text-sm font-medium text-gray-700 mb-1">Name *</label>
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
						<label for="phone" class="block text-sm font-medium text-gray-700 mb-1">Phone</label>
						<input 
							type="tel" 
							id="phone" 
							bind:value={formData.phone}
							class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-transparent"
						/>
					</div>

					<div>
						<label for="company" class="block text-sm font-medium text-gray-700 mb-1">Company</label>
						<input 
							type="text" 
							id="company" 
							bind:value={formData.company}
							class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-transparent"
						/>
					</div>

					<div>
						<label for="message" class="block text-sm font-medium text-gray-700 mb-1">Message *</label>
						<textarea 
							id="message" 
							bind:value={formData.message}
							required 
							rows="4" 
							class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-transparent"
						></textarea>
					</div>

					<button 
						type="submit" 
						class="w-full bg-blue-600 text-white py-3 rounded-md font-semibold hover:bg-blue-700 transition-colors"
					>
						Send Message
					</button>
				</form>
			</div>
		</div>
	</div>
</section>

