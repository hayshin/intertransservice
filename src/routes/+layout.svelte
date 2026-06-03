<script lang="ts">
	import { page } from '$app/state';
	import { locales, localizeHref } from '$lib/paraglide/runtime';
	import './layout.css';
	import favicon from '$lib/assets/favicon.svg';
	import Header from '$lib/components/Header.svelte';
	import Footer from '$lib/components/Footer.svelte';
	import CraneQuiz from '$lib/components/CraneQuiz.svelte';

	let { children } = $props();
</script>

<svelte:head><link rel="icon" href={favicon} /></svelte:head>

<div class="flex flex-col min-h-screen">
	<Header />
	
	<main class="flex-grow">
		{@render children()}
	</main>
	
	<Footer />
</div>

<!-- Quiz Component - Fixed button visible on all pages -->
<CraneQuiz />

<!-- Language selector (hidden but accessible for SEO) -->
<div style="display:none">
	{#each locales as locale}
		<a href={localizeHref(page.url.pathname, { locale })}>
			{locale}
		</a>
	{/each}
</div>
