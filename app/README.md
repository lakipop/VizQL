# VizQL Application

This directory contains the Nuxt 3 application for VizQL.

## Structure

```
app/
├── assets/
│   └── css/
│       └── main.css              # Tailwind base + custom styles
├── components/
│   ├── AppHeader.vue             # Top navigation bar
│   ├── DataVisualizer.vue        # Chart visualization
│   ├── QueryEditor.vue           # SQL query input
│   ├── ResultsTable.vue          # Table display
│   ├── SidebarLeft.vue           # Left navigation
│   └── SidebarRight.vue          # Right schema sidebar
├── pages/
│   └── index.vue                 # Main page
├── .env.example                  # Environment variables template
├── .gitignore                    # Git ignore rules
├── app.vue                       # Root layout
├── nuxt.config.ts                # Nuxt configuration
├── package.json                  # Dependencies
├── postcss.config.js             # PostCSS config
├── tailwind.config.ts            # Tailwind theme
└── tsconfig.json                 # TypeScript config
```

## Local Development

### Install Dependencies
```bash
npm install
```

### Run Development Server
```bash
npm run dev
```

Visit http://localhost:3000

### Build for Production
```bash
npm run build
```

### Preview Production Build
```bash
npm run preview
```

## Technologies

- **Nuxt 3** - Vue.js framework
- **Vue 3** - Composition API
- **TypeScript** - Type safety
- **Tailwind CSS** - Utility-first styling
- **Chart.js** - Data visualization
- **vue-chartjs** - Vue wrapper for Chart.js

## Component Auto-Import

Nuxt 3 automatically imports components from the `components/` directory.
No need to manually import them in your pages or other components.

```vue
<template>
  <!-- Just use it directly -->
  <QueryEditor @run-query="handleQuery" />
</template>
```

## Styling

All styling uses Tailwind CSS utilities. The theme is customized in `tailwind.config.ts` with:

- Matte, dark colors
- Compact spacing
- Small font sizes
- Professional appearance

Custom CSS is minimal and lives in `assets/css/main.css`.

## Type Safety

All components use TypeScript with strict mode enabled.

Props and emits are fully typed:

```vue
<script setup lang="ts">
interface Props {
  data: any[] | null
}

const props = defineProps<Props>()

const emit = defineEmits<{
  'run-query': [query: string]
}>()
</script>
```

## Development Tips

- Use Vue DevTools for debugging
- Check console logs for events
- Hot reload is enabled
- TypeScript errors show in terminal

---

For more details, see the parent directory's documentation files.
