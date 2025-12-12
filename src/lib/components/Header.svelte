<script lang="ts">
	import { page } from '$app/state';

	let mobileMenuOpen = $state(false);

	function toggleMobileMenu() {
		mobileMenuOpen = !mobileMenuOpen;
	}

	function closeMobileMenu() {
		mobileMenuOpen = false;
	}
</script>

<header class="bg-white shadow-md sticky top-0 z-50">
	<div class="container mx-auto px-4">
		<div class="flex items-center justify-between py-4">
			<!-- Logo -->
			<a href="/" class="text-2xl font-bold text-blue-600">
				InterTransService
			</a>

			<!-- Desktop Navigation -->
			<nav class="hidden md:flex items-center space-x-6">
				<div class="relative group">
					<button class="text-gray-700 hover:text-blue-600 transition-colors">
						About Us
					</button>
					<div class="absolute left-0 mt-2 w-56 bg-white shadow-lg rounded-md opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all">
						<a href="/about/quality" class="block px-4 py-2 text-gray-700 hover:bg-blue-50">Quality & Safety</a>
						<a href="/about/team" class="block px-4 py-2 text-gray-700 hover:bg-blue-50">Our Team</a>
						<a href="/about/news" class="block px-4 py-2 text-gray-700 hover:bg-blue-50">News</a>
					</div>
				</div>
				<a href="/products" class="text-gray-700 hover:text-blue-600 transition-colors">Products</a>
				<a href="/projects" class="text-gray-700 hover:text-blue-600 transition-colors">Projects</a>
				<a href="/partners" class="text-gray-700 hover:text-blue-600 transition-colors">Partners</a>
				<a href="/contacts" class="text-gray-700 hover:text-blue-600 transition-colors">Contacts</a>
			</nav>

			<!-- Contact Info -->
			<div class="hidden lg:flex items-center space-x-4 text-sm">
				<a href="tel:+77777777777" class="text-gray-700 hover:text-blue-600">
					+7 777 777 77 77
				</a>
			</div>

			<!-- Mobile Menu Button -->
			<button onclick={toggleMobileMenu} class="md:hidden text-gray-700" aria-label="Toggle mobile menu">
				<svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
					<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
				</svg>
			</button>
		</div>

		<!-- Mobile Navigation -->
		{#if mobileMenuOpen}
			<nav class="md:hidden pb-4 space-y-2">
				<a href="/about" class="block py-2 text-gray-700 hover:text-blue-600" onclick={closeMobileMenu}>About Us</a>
				<a href="/products" class="block py-2 text-gray-700 hover:text-blue-600" onclick={closeMobileMenu}>Products</a>
				<a href="/projects" class="block py-2 text-gray-700 hover:text-blue-600" onclick={closeMobileMenu}>Projects</a>
				<a href="/partners" class="block py-2 text-gray-700 hover:text-blue-600" onclick={closeMobileMenu}>Partners</a>
				<a href="/contacts" class="block py-2 text-gray-700 hover:text-blue-600" onclick={closeMobileMenu}>Contacts</a>
			</nav>
		{/if}
	</div>
</header>

