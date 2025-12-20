<script lang="ts">
	import logo from '$lib/assets/logo.png';
	import * as m from '$lib/paraglide/messages';
</script>

<footer class="bg-[#0a1f33] text-gray-300">
	<!-- Main footer content -->
	<div class="container mx-auto px-4 py-16">
		<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-12">
			<!-- Company Info -->
			<div class="lg:col-span-1">
				<div class="flex items-center gap-3 mb-6">
					<img src={logo} alt="InterTransService Logo" class="h-12 w-auto" />
					<div>
						<div class="text-white font-bold">InterTransService</div>
						<div class="text-xs text-gray-500 uppercase tracking-wider">{m.footer_tagline()}</div>
					</div>
				</div>
				<p class="text-sm leading-relaxed text-gray-400">
					{m.footer_description()}
				</p>
			</div>

			<!-- Information Links -->
			<div>
				<h4 class="text-white font-bold mb-6 text-lg">{m.footer_section_info()}</h4>
				<ul class="space-y-3 text-sm">
					<li><a href="/about" class="hover:text-[#c9a227] transition-colors">{m.footer_link_about()}</a></li>
					<li><a href="/partners" class="hover:text-[#c9a227] transition-colors">{m.footer_link_partners()}</a></li>
					<li><a href="/careers" class="hover:text-[#c9a227] transition-colors">{m.footer_link_careers()}</a></li>
					<li><a href="/contacts" class="hover:text-[#c9a227] transition-colors">{m.footer_link_contacts()}</a></li>
				</ul>
			</div>

			<!-- Products/Services -->
			<div>
				<h4 class="text-white font-bold mb-6 text-lg">{m.footer_section_services()}</h4>
				<ul class="space-y-3 text-sm">
					<li><a href="/products" class="hover:text-[#c9a227] transition-colors">{m.footer_service_transport()}</a></li>
					<li><a href="/products" class="hover:text-[#c9a227] transition-colors">{m.footer_service_international()}</a></li>
					<li><a href="/products" class="hover:text-[#c9a227] transition-colors">{m.footer_service_installation()}</a></li>
					<li><a href="/products" class="hover:text-[#c9a227] transition-colors">{m.footer_service_warehousing()}</a></li>
					<li><a href="/products" class="hover:text-[#c9a227] transition-colors">{m.footer_service_support()}</a></li>
				</ul>
			</div>

			<!-- Contact Information -->
			<div>
				<h4 class="text-white font-bold mb-6 text-lg">{m.footer_section_contacts()}</h4>
				<ul class="space-y-4 text-sm">
					<li class="flex items-start gap-3">
						<svg class="w-5 h-5 text-[#c9a227] mt-0.5 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
							<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"></path>
						</svg>
						<div>
							<div class="text-white font-medium">{m.footer_contact_phone_label()}</div>
							<a href="tel:+77019134104" class="hover:text-[#c9a227]">{m.footer_contact_phone()}</a>
							<div class="text-xs text-gray-500 mt-1">{m.footer_contact_messengers()}</div>
						</div>
					</li>
					<li class="flex items-start gap-3">
						<svg class="w-5 h-5 text-[#c9a227] mt-0.5 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
							<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"></path>
							<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"></path>
						</svg>
						<div>
							<div class="text-white font-medium">{m.footer_contact_address_label()}</div>
							<span>{m.footer_contact_address()}</span>
						</div>
					</li>
					<li class="flex items-start gap-3">
						<svg class="w-5 h-5 text-[#c9a227] mt-0.5 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
							<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path>
						</svg>
						<div>
							<div class="text-white font-medium">{m.footer_contact_email_label()}</div>
							<a href="mailto:its_aktau@mail.ru" class="hover:text-[#c9a227]">{m.footer_contact_email()}</a>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</div>

	<!-- Copyright bar -->
	<div class="border-t border-white/10">
		<div class="container mx-auto px-4 py-6 text-center text-sm text-gray-500">
			{m.footer_copyright({ year: new Date().getFullYear() })}
		</div>
	</div>
</footer>
