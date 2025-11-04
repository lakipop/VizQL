<template>
  <aside class="h-full flex flex-col p-3">
    <h2 class="text-xs font-semibold text-zinc-600 uppercase tracking-wider mb-3 px-2">
      Navigation
    </h2>
    
    <nav class="flex flex-col space-y-1">
      <button
        v-for="item in navItems"
        :key="item.id"
        @click="$emit('navigate', item.id)"
        :class="['nav-item', { 'nav-item-active': item.id === activeItem }]"
      >
        <component :is="item.icon" class="w-3.5 h-3.5" />
        <span class="text-xs">{{ item.label }}</span>
      </button>
    </nav>
  </aside>
</template>

<script setup lang="ts">
import { ref } from 'vue'

// Emits
defineEmits<{
  'navigate': [destination: string]
}>()

// Navigation items
const navItems = [
  { id: 'explorer', label: 'Explorer', icon: 'IconExplorer' },
  { id: 'queries', label: 'Queries', icon: 'IconQueries' },
  { id: 'dashboards', label: 'Dashboards', icon: 'IconDashboards' },
]

const activeItem = ref('queries')

// Icon components (inline SVG)
const IconExplorer = {
  template: `
    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 7v10a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-6l-2-2H5a2 2 0 00-2 2z" />
    </svg>
  `
}

const IconQueries = {
  template: `
    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 7h16M4 12h16M4 17h16" />
    </svg>
  `
}

const IconDashboards = {
  template: `
    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
    </svg>
  `
}
</script>

<style scoped>
.nav-item {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.375rem 0.5rem;
  border-radius: 0.25rem;
  color: #71717a;
  transition: all 150ms;
}

.nav-item:hover {
  color: #18181b;
  background-color: #e4e4e7;
}

.nav-item:focus {
  outline: 2px solid #e8c547;
  outline-offset: 2px;
}

.nav-item-active {
  background-color: #fef3c7;
  color: #ca8a04;
}
</style>
