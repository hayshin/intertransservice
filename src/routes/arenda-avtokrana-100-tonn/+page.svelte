<script lang="ts">
	import SeoLanding from '$lib/components/SeoLanding.svelte';
	import { getAllProducts, getProductCapacity } from '$lib/utils/products';

	const products = getAllProducts().filter((p) => getProductCapacity(p) === '100T');

	const title = 'Аренда автокрана 100 тонн';
	const description = 'Аренда крана 100 тонн: характеристики, цена за час, подбор под тяжёлые монтажные работы, опытный экипаж. Быстрый расчёт.';
	const h1 = 'Аренда автокрана 100 тонн';
	const lead = '100 тонн — решение для тяжёлых подъёмов на строительстве и промышленных объектах. Подберём модель и согласуем подачу под ваш график.';

	const bullets = [
		'Подбор по параметрам подъёма и схеме работ',
		'Документы и договор',
		'Опытный экипаж и соблюдение ТБ',
		'Быстрый расчёт стоимости'
	];

	const faq = [
		{ q: 'Можно ли заказать 100-тонный автокран на длительный срок?', a: 'Да. Уточните сроки и объект — предложим условия долгосрочной аренды.' },
		{ q: 'От чего зависит цена?', a: 'От времени работ, параметров подъёма, условий объекта и логистики.' }
	];

	const related = [
		{ href: '/ceny', label: 'Цены на аренду' },
		{ href: '/arenda-avtokrana', label: 'Все тоннажи' },
		{ href: '/arenda-avtokrana-80-tonn', label: 'Аренда автокрана 80 т' },
		{ href: '/products', label: 'Наш парк' }
	];
</script>

<SeoLanding {title} {description} {h1} {lead} {bullets} {faq} {related} />

{#if products.length}
	<section class="pb-20 bg-gray-100">
		<div class="container mx-auto px-4">
			<h2 class="text-2xl font-bold text-[#0f2942] mb-6">Доступные модели 100 т</h2>
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
