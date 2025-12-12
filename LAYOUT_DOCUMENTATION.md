# InterTransService Website Layout Documentation

This document describes the website structure created based on the KazEnergoMash website inspiration.

## 🎯 Overview

A professional B2B website for a construction machinery logistics company, featuring:
- Modern, responsive design using Tailwind CSS 4
- SvelteKit 2 with TypeScript
- Component-based architecture
- Ready for Paraglide i18n integration

## 📁 Project Structure

```
src/
├── lib/
│   └── components/
│       ├── Header.svelte           # Main navigation header
│       ├── Footer.svelte           # Site footer with contact info
│       ├── HeroSlider.svelte       # Auto-rotating hero section (3 slides)
│       ├── Advantages.svelte       # 4-card advantages section
│       ├── DirectorQuote.svelte    # Inspirational quote section
│       ├── ProductsShowcase.svelte # Services grid (6 items)
│       ├── LeadershipTeam.svelte   # Team member cards (4 leaders)
│       └── index.ts                # Component exports
│
└── routes/
    ├── +layout.svelte              # Root layout with Header & Footer
    ├── +page.svelte                # Home page (all main sections)
    ├── about/
    │   ├── +page.svelte            # About us page
    │   └── team/
    │       └── +page.svelte        # Team page
    ├── products/
    │   └── +page.svelte            # Services listing
    ├── projects/
    │   └── +page.svelte            # Project portfolio
    ├── partners/
    │   └── +page.svelte            # Partners page
    ├── contacts/
    │   └── +page.svelte            # Contact form & info
    └── careers/
        └── +page.svelte            # Careers & job application
```

## 🎨 Design Pattern

### Color Scheme
- Primary: Blue (#2563eb / blue-600)
- Gradients: Blue to purple/pink combinations
- Text: Gray scale for body content
- Accents: Green for success states

### Layout Sections (Home Page)

1. **Hero Slider** (3 rotating slides)
   - Slide 1: "Our Inspiration - Our Partners"
   - Slide 2: "Our Commitment - Our Quality"
   - Slide 3: "Our Strength - Our Team"
   - Auto-rotates every 5 seconds
   - Manual navigation dots
   - Pause on hover

2. **Advantages Section** (4 cards)
   - Experienced Team
   - Premium Quality
   - Modern Fleet
   - Full Compliance

3. **Director Quote**
   - Inspirational message
   - Director's name and title
   - Blue gradient background

4. **Products/Services Showcase** (6 items)
   - Heavy Machinery Transport
   - International Shipping
   - Equipment Installation
   - Warehousing Solutions
   - Parts Supply
   - Technical Support

5. **Leadership Team** (4 members)
   - Avatar placeholders with initials
   - Name and position
   - Hover effects

## 🔧 Components Overview

### Header.svelte
- Sticky navigation
- Logo/brand name
- Desktop navigation with dropdown (About Us)
- Mobile hamburger menu
- Contact phone number (desktop only)
- Fully responsive

### Footer.svelte
- 3-column layout
- Company info
- Quick links
- Contact information with icons
- Copyright notice

### HeroSlider.svelte
**Props:** None (uses internal data)
**Features:**
- Auto-play with 5s interval
- Pause on mouse hover
- Smooth opacity transitions
- Navigation indicators
- Gradient backgrounds

### Advantages.svelte
**Props:** None (uses internal data)
**Data structure:**
```typescript
interface Advantage {
  icon: string;
  title: string;
  description: string;
}
```

### DirectorQuote.svelte
**Props:** None (hardcoded content)
**Content:** Inspirational quote + director info

### ProductsShowcase.svelte
**Props:** None (uses internal data)
**Data structure:**
```typescript
interface Product {
  title: string;
  description: string;
  icon: string;
}
```

### LeadershipTeam.svelte
**Props:** None (uses internal data)
**Data structure:**
```typescript
interface Leader {
  name: string;
  position: string;
  initials: string;
}
```

## 📄 Pages

### Home (`/`)
All main sections combined in order:
1. Hero Slider
2. Advantages
3. Director Quote
4. Products Showcase
5. Leadership Team

### About (`/about`)
- Company story
- Values section (3 cards)
- CTA to contact

### About > Team (`/about/team`)
- Leadership team component
- Team description
- Join team CTA

### Products/Services (`/products`)
- Detailed service cards (6 items)
- Feature lists with checkmarks
- Custom solution CTA

### Projects (`/projects`)
- Project cards (6 sample projects)
- Category badges
- Client names
- Year completed

### Partners (`/partners`)
- Partner grid (8 placeholder spots)
- Partner categories (3 types)
- Become a partner CTA

### Contacts (`/contacts`)
- Contact information (4 sections)
- Contact form
- Success message on submit

### Careers (`/careers`)
- Why work with us (3 benefits)
- Open positions list (3 sample jobs)
- Resume submission form

## 🎯 Sample Content Theme

**Industry:** Construction Machinery Logistics
**Company Name:** InterTransService
**Location:** Almaty, Kazakhstan
**Services:**
- Heavy equipment transportation
- International shipping
- Equipment installation
- Warehousing
- Parts supply
- Technical support

## 🌐 Internationalization (TODO)

The site is ready for Paraglide integration. All text content should be:
1. Extracted to message files
2. Translated to Russian, Kazakh, and English
3. Replaced with `m.key()` function calls

**Current message structure:**
```
messages/
├── en.json
├── ru.json
└── kk.json
```

**Next steps for i18n:**
1. Create message folders (e.g., `messages/home/`, `messages/common/`)
2. Add to `project.inlang/settings.json`
3. Extract all hardcoded strings
4. Replace with Paraglide calls

## 🚀 Running the Project

```bash
# Install dependencies
bun install

# Run development server
bun run dev

# Build for production
bun run build

# Preview production build
bun run preview
```

## ✏️ Customization Guide

### To Update Content:

1. **Company Information**
   - Edit: `src/lib/components/Header.svelte` (logo, phone)
   - Edit: `src/lib/components/Footer.svelte` (contact details)

2. **Hero Slides**
   - Edit: `src/lib/components/HeroSlider.svelte`
   - Modify `slides` array

3. **Advantages**
   - Edit: `src/lib/components/Advantages.svelte`
   - Modify `advantages` array

4. **Services**
   - Edit: `src/lib/components/ProductsShowcase.svelte`
   - Modify `products` array

5. **Team Members**
   - Edit: `src/lib/components/LeadershipTeam.svelte`
   - Modify `leaders` array

### To Add Images:

1. Place images in `static/images/`
2. Reference as `/images/filename.jpg`
3. Replace emoji icons with actual images

Example:
```svelte
<img src="/images/service-icon.svg" alt="Service" />
```

### To Add New Pages:

1. Create `src/routes/your-page/+page.svelte`
2. Add navigation link in `Header.svelte`
3. Follow existing page structure

## 🎨 Styling Notes

- Uses Tailwind CSS 4
- Responsive breakpoints: `md:` (768px), `lg:` (1024px)
- Container max-width with auto margins
- Consistent spacing: `py-16` for sections
- Hover effects on interactive elements
- Shadow elevations for depth

## 📱 Responsive Behavior

- **Mobile (<768px):** Single column, hamburger menu
- **Tablet (768px-1024px):** 2 columns for grids
- **Desktop (>1024px):** Full navigation, 3-4 column grids

## ✅ Accessibility Features

- Semantic HTML elements
- ARIA labels on interactive elements
- Keyboard navigation support
- Alt text ready (add when images added)
- Focus states on form elements

## 🔜 Recommended Next Steps

1. **Add Real Content:** Replace placeholder text with actual company information
2. **Add Images:** Replace emojis with professional photos/icons
3. **Implement i18n:** Extract strings to Paraglide messages
4. **Add Forms:** Integrate contact/resume forms with backend
5. **SEO:** Add more meta tags, structured data
6. **Analytics:** Add tracking codes
7. **Performance:** Optimize images, add lazy loading
8. **Testing:** Add E2E tests for critical flows

## 📝 Notes

- All components use Svelte 5 syntax (`$state`, `$props`)
- No arrow functions (per workspace rules)
- Functional style preferred
- Ready for Docker deployment
- Static adapter configured

