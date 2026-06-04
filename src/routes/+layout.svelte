<script lang="ts">
	import { browser } from '$app/environment';
	import { page } from '$app/state';
	import { locales, localizeHref } from '$lib/paraglide/runtime';
	import { PUBLIC_SITE_URL } from '$env/static/public';

	import './layout.css';
	import favicon from '$lib/assets/favicon.svg';
	import Header from '$lib/components/Header.svelte';
	import Footer from '$lib/components/Footer.svelte';
	import CraneQuiz from '$lib/components/CraneQuiz.svelte';

	let { children } = $props();

	const pathname = $derived(page.url.pathname);
	const normalizedPath = $derived(pathname.endsWith('/') ? pathname : `${pathname}/`);
	const canonical = $derived(`${PUBLIC_SITE_URL}${normalizedPath}`);
</script>

<svelte:head>
	<link rel="icon" href={favicon} />
	<link rel="canonical" href={canonical} />
</svelte:head>

<div class="flex flex-col min-h-screen">
	<Header />

	<main class="flex-grow">
		{@render children()}
	</main>

	<Footer />
</div>

{#if browser}
	<CraneQuiz />
{/if}

<div style="display:none">
	{#each locales as locale}
		<a href={localizeHref(page.url.pathname, { locale })}>{locale}</a>
	{/each}
</div>