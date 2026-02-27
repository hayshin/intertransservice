import type { RequestHandler } from './$types';
import { getAllProducts } from '$lib/utils/products';

export const prerender = true;

const SITE_URL = 'https://intertransservice.kz';


// A small, pragmatic sitemap focused on money-pages.
function url(path: string): string {
	if (!path.startsWith('/')) path = `/${path}`;
	return `${SITE_URL}${path}`;
}

export const GET: RequestHandler = async () => {
	const staticRoutes: string[] = [
		'/',
		'/arenda-avtokrana',
		'/ceny',
		'/avtokrany-xcmg',
		'/avtokrany-liebherr',
		'/arenda-avtokrana-25-tonn',
		'/arenda-avtokrana-40-tonn',
		'/arenda-avtokrana-50-tonn',
		'/arenda-avtokrana-80-tonn',
		'/arenda-avtokrana-100-tonn',
		'/products',
		'/contacts',
		'/about'
	];

	const productUrls = getAllProducts().map((p) => `/products/${p.slug}`);

	const urls = [...staticRoutes, ...productUrls]
		// de-dup
		.filter((v, i, a) => a.indexOf(v) === i);

	const now = new Date().toISOString();

	const body = `<?xml version="1.0" encoding="UTF-8"?>\n` +
		`<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n` +
		urls
			.map((path) => {
				const loc = url(path);
				return `  <url>\n    <loc>${loc}</loc>\n    <lastmod>${now}</lastmod>\n  </url>`;
			})
			.join('\n') +
		`\n</urlset>`;

	return new Response(body, {
		headers: {
			'Content-Type': 'application/xml; charset=utf-8',
			'Cache-Control': 'public, max-age=3600'
		}
	});
};
