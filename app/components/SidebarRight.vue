<template>
  <aside class="h-full flex flex-col p-3">
    <h2 class="text-xs font-semibold text-zinc-600 uppercase tracking-wider mb-3 px-2">
      Database Schema
    </h2>
    
    <!-- No Connection State -->
    <div v-if="!schema || Object.keys(schema).length === 0" class="schema-placeholder flex-1">
      <div class="text-xxs text-zinc-500 px-2 space-y-2">
        <p>Connect to a database to view schema</p>
        
        <div class="mt-4 space-y-1 text-zinc-400">
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
            <span>└ Columns</span>
          </div>
        </div>
      </div>
    </div>

    <!-- Schema Tree View -->
    <div v-else class="schema-tree flex-1 overflow-y-auto">
      <div v-for="(columns, tableName) in schema" :key="tableName" class="table-group">
        <div class="table-name">
          <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M3 14h18m-9-4v8m-7 0h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v8a2 2 0 002 2z" />
          </svg>
          <span>{{ tableName }}</span>
        </div>
        <div class="columns-list">
          <div v-for="(column, idx) in columns" :key="idx" class="column-item">
            {{ column }}
          </div>
        </div>
      </div>
    </div>
  </aside>
</template>

<script setup lang="ts">
// Props
interface Props {
  schema?: Record<string, string[]> | null
}

defineProps<Props>()
</script>

<style scoped>
.schema-placeholder {
  border: 1px dashed #d4d4d8;
  border-radius: 0.25rem;
  padding: 0.75rem;
  background-color: #f4f4f5;
}

.schema-tree {
  font-size: 0.7rem;
  color: #3f3f46;
}

.table-group {
  margin-bottom: 0.75rem;
}

.table-name {
  display: flex;
  align-items: center;
  gap: 0.25rem;
  padding: 0.25rem 0.5rem;
  background-color: #fafafa;
  border-left: 2px solid #22c55e;
  font-weight: 600;
  color: #18181b;
  margin-bottom: 0.25rem;
}

.columns-list {
  padding-left: 1.25rem;
}

.column-item {
  padding: 0.125rem 0.5rem;
  color: #52525b;
  font-family: 'Courier New', monospace;
  font-size: 0.65rem;
  line-height: 1.5;
}

.column-item:hover {
  background-color: #f4f4f5;
  color: #18181b;
}
</style>
