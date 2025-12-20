import * as m from '$lib/paraglide/messages';

export interface ProductSpec {
	key: string;
	value: string;
}

export interface Product {
	slug: string;
	name: string;
	type: string;
	image: string;
	shortDescription: string;
	features: string[];
	specs: ProductSpec[];
	fullDescription: string;
}

const productsData: Record<string, Omit<Product, 'slug'>> = {
	sany_30: {
		name: m.product_sany_30_name(),
		type: m.product_sany_30_type(),
		image: '/products/sany_30.webp',
		shortDescription: m.product_sany_30_short_desc(),
		features: [
			m.product_sany_30_feature_1(),
			m.product_sany_30_feature_2(),
			m.product_sany_30_feature_3(),
			m.product_sany_30_feature_4(),
			m.product_sany_30_feature_5()
		],
		specs: [
			{ key: m.spec_counterweight(), value: '5,9T' },
			{ key: m.spec_max_capacity(), value: '30T' },
			{ key: m.spec_max_boom_length(), value: '42,5m' },
			{ key: m.spec_max_jib_length(), value: '8m' },
			{ key: m.spec_max_lift_height(), value: '51m' },
			{ key: m.spec_max_lift_moment(), value: '1158kN·m' },
			{ key: m.spec_available_regions(), value: 'LHD countries' },
			{ key: m.spec_engine_model(), value: 'DF Cummins ISLe290 30 (Euro Ⅲ)' },
			{ key: m.spec_max_gradeability(), value: '42%' },
			{ key: m.spec_max_travel_speed(), value: '90km/h' },
			{ key: m.spec_wheel_formula(), value: '6 × 4' }
		],
		fullDescription: m.product_sany_30_full_description()
	},
	sany_50: {
		name: m.product_sany_50_name(),
		type: m.product_sany_50_type(),
		image: '/products/sany_50.jpg',
		shortDescription: m.product_sany_50_short_desc(),
		features: [
			m.product_sany_50_feature_1(),
			m.product_sany_50_feature_2(),
			m.product_sany_50_feature_3(),
			m.product_sany_50_feature_4(),
			m.product_sany_50_feature_5()
		],
		specs: [
			{ key: m.spec_counterweight(), value: '8,5T' },
			{ key: m.spec_max_capacity(), value: '50T' },
			{ key: m.spec_max_boom_length(), value: '44m' },
			{ key: m.spec_max_jib_length(), value: '16m' },
			{ key: m.spec_max_lift_height(), value: '60,5m' },
			{ key: m.spec_max_lift_moment(), value: '1600kN·m' },
			{ key: m.spec_available_regions(), value: 'LHD countries' },
			{ key: m.spec_engine_model(), value: 'DF Cummins ISLe340 40 (Euro III)' },
			{ key: m.spec_max_gradeability(), value: '45%' },
			{ key: m.spec_max_travel_speed(), value: '90km/h' },
			{ key: m.spec_wheel_formula(), value: '8×4×4' }
		],
		fullDescription: m.product_sany_50_full_description()
	},
	sany_80: {
		name: m.product_sany_80_name(),
		type: m.product_sany_80_type(),
		image: '/products/sany_80.jpg',
		shortDescription: m.product_sany_80_short_desc(),
		features: [
			m.product_sany_80_feature_1(),
			m.product_sany_80_feature_2(),
			m.product_sany_80_feature_3(),
			m.product_sany_80_feature_4(),
			m.product_sany_80_feature_5()
		],
		specs: [
			{ key: m.spec_counterweight(), value: '12 (standard) +6 (optional)T' },
			{ key: m.spec_max_capacity(), value: '80T' },
			{ key: m.spec_max_boom_length(), value: '50,5m' },
			{ key: m.spec_max_jib_length(), value: '16m' },
			{ key: m.spec_max_lift_height(), value: '76m' },
			{ key: m.spec_max_lift_moment(), value: '2940kN·m' },
			{ key: m.spec_available_regions(), value: 'LHD&RHD' },
			{ key: m.spec_engine_model(), value: 'DF Cummins ISLe375 30 (Euro III)' },
			{ key: m.spec_max_gradeability(), value: '44%' },
			{ key: m.spec_max_travel_speed(), value: '90km/h' },
			{ key: m.spec_wheel_formula(), value: '8×4' }
		],
		fullDescription: m.product_sany_80_full_description()
	},
	sany_100: {
		name: m.product_sany_100_name(),
		type: m.product_sany_100_type(),
		image: '/products/sany_100.webp',
		shortDescription: m.product_sany_100_short_desc(),
		features: [
			m.product_sany_100_feature_1(),
			m.product_sany_100_feature_2(),
			m.product_sany_100_feature_3(),
			m.product_sany_100_feature_4(),
			m.product_sany_100_feature_5()
		],
		specs: [
			{ key: m.spec_counterweight(), value: '30.2T' },
			{ key: m.spec_max_capacity(), value: '100T' },
			{ key: m.spec_max_boom_length(), value: '60m' },
			{ key: m.spec_max_jib_length(), value: '27m' },
			{ key: m.spec_max_lift_height(), value: '87m' },
			{ key: m.spec_max_lift_moment(), value: '3557.5kN·m' },
			{ key: m.spec_available_regions(), value: 'LHD area' },
			{ key: m.spec_engine_model(), value: 'DF Cummins ISLe375 30(Euro Ⅲ)' },
			{ key: m.spec_max_gradeability(), value: '45%' },
			{ key: m.spec_max_travel_speed(), value: '80km/h' },
			{ key: m.spec_wheel_formula(), value: '8×4×4' }
		],
		fullDescription: m.product_sany_100_full_description()
	}
};

export function getAllProducts(): Product[] {
	return Object.entries(productsData).map(([slug, data]) => ({
		...data,
		slug
	}));
}

export function getProductBySlug(slug: string): Product | null {
	const product = productsData[slug];
	if (!product) return null;
	return {
		...product,
		slug
	};
}

export function getProductCapacity(product: Product): string {
	return product.specs.find(s => 
		s.key === m.spec_max_capacity()
	)?.value || '—';
}

export function getProductMaxHeight(product: Product): string {
	return product.specs.find(s => 
		s.key === m.spec_max_lift_height()
	)?.value || '—';
}

