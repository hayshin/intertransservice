<script lang="ts">
	import logo from '$lib/assets/logo.png';
	import LanguageSwitcher from './LanguageSwitcher.svelte';
	import * as m from '$lib/paraglide/messages';

	let mobileMenuOpen = $state(false);

	function toggleMobileMenu() {
		mobileMenuOpen = !mobileMenuOpen;
	}

	function closeMobileMenu() {
		mobileMenuOpen = false;
	}
</script>

<header class="bg-[#0f2942] text-white sticky top-0 z-50">
	<!-- Top bar with contact info -->
	<div class="bg-[#0a1f33] border-b border-white/10">
		<div class="container mx-auto px-4 py-2 flex justify-between items-center text-sm">
			<div class="flex items-center gap-6">
				<a href="tel:+77019134104" class="flex items-center gap-2 text-gray-300 hover:text-white transition-colors">
					<svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"></path>
					</svg>
					{m.header_phone()}
				</a>
				<a href="mailto:its_aktau@mail.ru" class="hidden sm:flex items-center gap-2 text-gray-300 hover:text-white transition-colors">
					<svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path>
					</svg>
					{m.header_email()}
				</a>
			</div>
			<div class="hidden md:flex items-center gap-4 text-gray-300">
				<span class="flex items-center gap-2">
					<svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"></path>
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"></path>
					</svg>
					{m.header_location()}
				</span>
			</div>
		</div>
	</div>

	<!-- Main navigation -->
	<div class="container mx-auto px-4">
		<div class="flex items-center justify-between py-4">
			<!-- Logo -->
			<a href="/" class="flex items-center gap-3">
				<img src={logo} alt="InterTransService Logo" class="h-12 w-auto" />
				<div class="hidden sm:block">
					<div class="text-lg font-bold tracking-wide">InterTransService</div>
					<div class="text-xs text-gray-400 tracking-wider uppercase">{m.header_tagline()}</div>
				</div>
			</a>

			<!-- Desktop Navigation -->
			<nav class="hidden lg:flex items-center gap-1">
				<div class="relative group">
					<button class="nav-link px-4 py-2 text-gray-200 hover:text-white transition-colors flex items-center gap-1">
						{m.header_nav_about()}
						<svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
							<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
						</svg>
					</button>
					<div class="absolute left-0 mt-0 w-56 bg-[#0f2942] border border-white/10 shadow-xl opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all">
						<a href="/about" class="block px-4 py-3 text-gray-300 hover:text-white hover:bg-white/5 border-b border-white/5">{m.header_nav_about_dropdown()}</a>
						<a href="/about/quality" class="block px-4 py-3 text-gray-300 hover:text-white hover:bg-white/5 border-b border-white/5">{m.header_nav_about_quality()}</a>
						<a href="/about/team" class="block px-4 py-3 text-gray-300 hover:text-white hover:bg-white/5">{m.header_nav_about_team()}</a>
					</div>
				</div>
				<a href="/products" class="nav-link px-4 py-2 text-gray-200 hover:text-white transition-colors">{m.header_nav_services()}</a>
				<a href="/projects" class="nav-link px-4 py-2 text-gray-200 hover:text-white transition-colors">{m.header_nav_projects()}</a>
				<a href="/partners" class="nav-link px-4 py-2 text-gray-200 hover:text-white transition-colors">{m.header_nav_partners()}</a>
				<a href="/contacts" class="nav-link px-4 py-2 text-gray-200 hover:text-white transition-colors">{m.header_nav_contacts()}</a>
				
				<div class="ml-2 border-l border-white/20 pl-2">
					<LanguageSwitcher />
				</div>
			</nav>

			<!-- Mobile Menu and Language Switcher -->
			<div class="lg:hidden flex items-center gap-2">
				<LanguageSwitcher />
				<button onclick={toggleMobileMenu} class="text-white p-2" aria-label="Toggle mobile menu">
					<svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
						{#if mobileMenuOpen}
							<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
						{:else}
							<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
						{/if}
					</svg>
				</button>
			</div>
		</div>

		<!-- Mobile Navigation -->
		{#if mobileMenuOpen}
			<nav class="lg:hidden border-t border-white/10 py-4 space-y-1">
				<a href="/about" class="block py-3 px-4 text-gray-200 hover:text-white hover:bg-white/5" onclick={closeMobileMenu}>{m.header_nav_about()}</a>
				<a href="/products" class="block py-3 px-4 text-gray-200 hover:text-white hover:bg-white/5" onclick={closeMobileMenu}>{m.header_nav_services()}</a>
				<a href="/projects" class="block py-3 px-4 text-gray-200 hover:text-white hover:bg-white/5" onclick={closeMobileMenu}>{m.header_nav_projects()}</a>
				<a href="/partners" class="block py-3 px-4 text-gray-200 hover:text-white hover:bg-white/5" onclick={closeMobileMenu}>{m.header_nav_partners()}</a>
				<a href="/contacts" class="block py-3 px-4 text-gray-200 hover:text-white hover:bg-white/5" onclick={closeMobileMenu}>{m.header_nav_contacts()}</a>
			</nav>
		{/if}
	</div>
</header>
