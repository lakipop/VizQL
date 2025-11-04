<template>
  <div class="results-table-container">
    <div class="table-header">
      <h3 class="text-xs font-semibold text-gray-400">Query Results</h3>
      <span v-if="data && data.length > 0" class="text-xxs text-gray-600">
        {{ data.length }} row{{ data.length !== 1 ? 's' : '' }}
      </span>
    </div>
    
    <!-- Empty State -->
    <div v-if="!data || data.length === 0" class="empty-state">
      <svg class="w-8 h-8 text-gray-700 mb-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4" />
      </svg>
      <p class="text-xs text-gray-600">No results to display</p>
      <p class="text-xxs text-gray-700 mt-1">Run a query to see results here</p>
    </div>
    
    <!-- Table -->
    <div v-else class="table-wrapper">
      <table class="results-table">
        <thead>
          <tr>
            <th v-for="col in columns" :key="col" class="table-header-cell">
              {{ col }}
            </th>
          </tr>
        </thead>
        <tbody>
          <tr 
            v-for="(row, idx) in data" 
            :key="idx"
            class="table-row"
          >
            <td v-for="col in columns" :key="col" class="table-cell">
              {{ row[col] }}
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'

// Props
interface Props {
  data: any[] | null
}

const props = defineProps<Props>()

// Computed
const columns = computed(() => {
  if (!props.data || props.data.length === 0) return []
  return Object.keys(props.data[0])
})
</script>

<style scoped>
.results-table-container {
  @apply flex flex-col h-full border border-gray-800 rounded bg-gray-900;
}

.table-header {
  @apply flex items-center justify-between px-3 py-2 border-b border-gray-800;
}

.empty-state {
  @apply flex flex-col items-center justify-center flex-1;
  @apply text-center;
}

.table-wrapper {
  @apply flex-1 overflow-auto;
}

.results-table {
  @apply w-full text-xs;
}

.table-header-cell {
  @apply sticky top-0 px-3 py-2 text-left text-xxs font-semibold;
  @apply bg-gray-800 text-yellow-400 uppercase tracking-wider;
  @apply border-b border-gray-700;
}

.table-row {
  @apply transition-colors duration-100;
}

.table-row:nth-child(even) {
  @apply bg-gray-900/50;
}

.table-row:hover {
  @apply bg-gray-800/50;
}

.table-cell {
  @apply px-3 py-2 text-gray-300;
  @apply border-b border-gray-800/50;
}
</style>
