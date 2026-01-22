<script lang="ts">
	import SeoLanding from '$lib/components/SeoLanding.svelte';

	const title = 'Автокраны Liebherr в аренду';
	const description = 'Аренда автокранов Liebherr: подбор модели по тоннажу, консультация, документы. Узнайте цену и сроки подачи.';
	const h1 = 'Автокраны Liebherr в аренду';

	const lead = 'Если вам нужен автокран Liebherr (100+ тонн или специфические параметры подъёма) — опишите задачу, мы подберём решение и согласуем условия.';

	const bullets = [
		'Подбор Liebherr по параметрам: тоннаж, высота, вылет стрелы',
		'Расчёт стоимости под вашу задачу',
		'Документы и согласование графика работ'
	];

	const faq = [
		{ q: 'Какие Liebherr доступны?', a: 'Наличие зависит от графика и требуемых характеристик. Оставьте запрос — подберём варианты.' },
		{ q: 'Сколько стоит Liebherr в аренду?', a: 'Цена зависит от модели, длительности работ и логистики. Быстро рассчитаем после уточнения параметров.' }
	];

	const related = [
		{ href: '/arenda-avtokrana', label: 'Аренда автокрана' },
		{ href: '/ceny', label: 'Цены' },
		{ href: '/products', label: 'Наш парк (XCMG / SANY)' }
	];
</script>

<SeoLanding eyebrow="БРЕНД" {title} {description} {h1} {lead} {bullets} {faq} {related} />