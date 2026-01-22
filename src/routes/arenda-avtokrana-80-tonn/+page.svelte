<script lang="ts">
	import SeoLanding from '$lib/components/SeoLanding.svelte';
	import { getAllProducts, getProductCapacity } from '$lib/utils/products';

	const products = getAllProducts().filter((p) => getProductCapacity(p) === '80T');

	const title = 'Аренда автокрана 80 тонн';
	const description = 'Аренда крана 80 тонн: характеристики, цена за час, подбор под тяжёлый монтаж, опытный экипаж. Быстрый расчёт.';
	const h1 = 'Аренда автокрана 80 тонн';
	const lead = '80 тонн — отличный выбор для тяжёлого монтажа, установки оборудования и работ на промышленных объектах.';

	const bullets = [
		'Подбор по параметрам подъёма: высота, вылет, масса груза',
		'Документы и договор',
		'Опытные машинисты и соблюдение ТБ',
		'Быстрый расчёт стоимости'
	];

	const faq = [
		{ q: 'Подойдёт ли 80 тонн для моей задачи?', a: 'Нужно знать вес груза, высоту и вылет стрелы. По этим данным подберём оптимальную технику.' },
		{ q: 'Сколько стоит аренда 80-тонника?', a: 'Цена зависит от времени работ, объекта и логистики. Оставьте заявку — быстро рассчитаем.' }
	];

	const related = [
		{ href: '/ceny', label: 'Цены на аренду' },
		{ href: '/arenda-avtokrana', label: 'Все тоннажи' },
		{ href: '/arenda-avtokrana-50-tonn', label: 'Аренда автокрана 50 т' },
		{ href: '/arenda-avtokrana-100-tonn', label: 'Аренда автокрана 100 т' }
	];
</script>

<SeoLanding {title} {description} {h1} {lead} {bullets} {faq} {related} />

{#if products.length}
	<section class="pb-20 bg-gray-100">
		<div class="container mx-auto px-4">
			<h2 class="text-2xl font-bold text-[#0f2942] mb-6">Доступные модели 80 т</h2>
			<div class="grid grid-cols-1 md:grid-cols-2 gap-8">
				{#each products as p}
					<a href={`/products/${p.slug}`} class="group">
						<div class="card-industrial bg-white overflow-hidden">
							<div class="relative h-56 overflow-hidden bg-gray-200">
								<enhanced:img src={p.image} alt={p.name} class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" />
								<div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent"></div>
								<div class="absolute bottom-4 left-4 right-4">
									<div class="text-[#c9a227] text-sm font-semibold mb-1">{p.type}</div>
									<h3 class="text-2xl font-bold text-white">{p.name}</h3>
								</div>
							</div>
							<div class="p-6">
								<p class="text-gray-700">{p.shortDescription}</p>
								<div class="mt-4 inline-flex items-center gap-2 text-[#c9a227] font-semibold">Смотреть характеристики</div>
							</div>
						</div>
					</a>
				{/each}
			</div>
		</div>
	</section>
{/if}
