<script lang="ts">
	import SeoLanding from '$lib/components/SeoLanding.svelte';
	import { getAllProducts } from '$lib/utils/products';

	const xcmg = getAllProducts().filter(p => p.slug.startsWith('xcmg_'));

	const title = 'Автокраны XCMG в аренду';
	const description = 'Аренда автокранов XCMG (30–100 тонн). Технические характеристики, подбор тоннажа, быстрый расчёт стоимости.';
	const h1 = 'Автокраны XCMG в аренду';
	const lead = 'XCMG — популярные автокраны для стройки и промышленности. Подберём подходящую модель по тоннажу и параметрам подъёма.';

	const bullets = [
		'Подбор модели XCMG под вес, высоту и вылет стрелы',
		'Опытный экипаж и работа по договору',
		'Доступные тоннажи из парка: 30 / 50 / 80 / 100 т'
	];

	const faq = [
		{ q: 'XCMG 25 тонн есть?', a: 'Если нужен 25 т — уточните задачу: подберём ближайший по параметрам вариант и согласуем условия.' },
		{ q: 'Как быстро вы можете подать технику?', a: 'Зависит от графика и локации. Позвоните или оставьте заявку — согласуем подачу.' }
	];

	const related = [
		{ href: '/arenda-avtokrana', label: 'Аренда автокрана' },
		{ href: '/ceny', label: 'Цены' },
		{ href: '/products', label: 'Все автокраны' }
	];
</script>

<SeoLanding eyebrow="БРЕНД" {title} {description} {h1} {lead} {bullets} {faq} {related} />

<section class="pb-20 bg-gray-100">
	<div class="container mx-auto px-4">
		<div class="grid grid-cols-1 md:grid-cols-2 gap-8">
			{#each xcmg as p}
				<a href={`/products/${p.slug}`} class="group">
					<div class="card-industrial bg-white overflow-hidden">
						<div class="relative h-56 overflow-hidden bg-gray-200">
							<enhanced:img src={p.image} alt={p.name} class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" />
							<div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent"></div>
							<div class="absolute bottom-4 left-4 right-4">
								<div class="text-[#c9a227] text-sm font-semibold mb-1">{p.type}</div>
								<h2 class="text-2xl font-bold text-white">{p.name}</h2>
							</div>
						</div>
						<div class="p-6">
							<p class="text-gray-700">{p.shortDescription}</p>
							<div class="mt-4 inline-flex items-center gap-2 text-[#c9a227] font-semibold">
								Смотреть характеристики
								<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
									<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3"></path>
								</svg>
							</div>
						</div>
					</div>
				</a>
			{/each}
		</div>
	</div>
</section>