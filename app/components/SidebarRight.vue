<template>
  <aside class="h-full flex flex-col p-3">
    <h2 class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-3 px-2">
      Database Schema
    </h2>
    
    <div class="schema-placeholder flex-1">
      <div class="text-xxs text-gray-600 px-2 space-y-2">
        <p>Connect to a database to view schema</p>
        
        <div class="mt-4 space-y-1 text-gray-700">
          <div class="flex items-center space-x-1">
            <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 7v10c0 2.21 3.582 4 8 4s8-1.79 8-4V7M4 7c0 2.21 3.582 4 8 4s8-1.79 8-4M4 7c0-2.21 3.582-4 8-4s8 1.79 8 4" />
            </svg>
            <span>└ Tables</span>
          </div>
          <div class="flex items-center space-x-1 ml-4">
            <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M3 14h18m-9-4v8m-7 0h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v8a2 2 0 002 2z" />
            </svg>
            <span>└ Views</span>
          </div>
          <div class="flex items-center space-x-1 ml-4">
            <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 9l3 3-3 3m5 0h3M5 20h14a2 2 0 002-2V6a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
            </svg>
            <span>└ Functions</span>
          </div>
        </div>
      </div>
    </div>
  </aside>
</template>

<script setup lang="ts">
// Props (for future use)
interface Props {
  schema?: any
}

defineProps<Props>()
</script>

<style scoped>
.schema-placeholder {
  @apply border border-dashed border-gray-800 rounded p-3;
  @apply bg-gray-900/50;
}
</style>
