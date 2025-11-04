<template>
  <div class="query-editor-container">
    <div class="editor-header">
      <h3 class="text-xs font-semibold text-gray-400">Query Editor</h3>
      <button
        @click="runQuery"
        :disabled="!query.trim()"
        class="run-button"
        :class="{ 'opacity-50 cursor-not-allowed': !query.trim() }"
      >
        <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.752 11.168l-3.197-2.132A1 1 0 0010 9.87v4.263a1 1 0 001.555.832l3.197-2.132a1 1 0 000-1.664z" />
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
        </svg>
        Run Query
      </button>
    </div>
    
    <textarea
      v-model="query"
      placeholder="Enter your SQL query here...&#10;&#10;Example:&#10;SELECT * FROM users WHERE active = 1;"
      class="query-textarea font-mono-code"
      @keydown.ctrl.enter="runQuery"
    ></textarea>
    
    <div class="editor-footer">
      <span class="text-xxs text-gray-600">Ctrl+Enter to run</span>
      <span class="text-xxs text-gray-600">{{ query.length }} characters</span>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'

// Emits
const emit = defineEmits<{
  'run-query': [query: string]
}>()

// State
const query = ref('')

// Methods
const runQuery = () => {
  if (query.value.trim()) {
    emit('run-query', query.value)
  }
}
</script>

<style scoped>
.query-editor-container {
  @apply flex flex-col h-full border border-gray-800 rounded bg-gray-900;
}

.editor-header {
  @apply flex items-center justify-between px-3 py-2 border-b border-gray-800;
}

.run-button {
  @apply flex items-center px-2 py-1 text-xs rounded;
  @apply bg-green-500/10 text-green-500 border border-green-500;
  @apply hover:bg-green-500/20 transition-all duration-150;
  @apply focus:outline-none focus:ring-1 focus:ring-green-400;
}

.query-textarea {
  @apply flex-1 w-full px-3 py-2 resize-none;
  @apply bg-black text-gray-300 text-xs;
  @apply focus:outline-none focus:ring-1 focus:ring-yellow-400;
  @apply placeholder-gray-700;
  line-height: 1.5;
}

.editor-footer {
  @apply flex items-center justify-between px-3 py-1 border-t border-gray-800;
  @apply bg-gray-900/50;
}
</style>
