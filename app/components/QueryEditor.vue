<template>
  <div class="query-editor-container">
    <div class="editor-header">
      <h3 class="text-xs font-semibold text-gray-400">Query Editor</h3>
      <button
        @click="runQuery"
        :disabled="!query.trim() || disabled"
        class="run-button"
        :class="{ 'opacity-50 cursor-not-allowed': !query.trim() || disabled }"
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
      :placeholder="disabled ? 'Connect to a database first...' : 'Enter your SQL query here...&#10;&#10;Example:&#10;SELECT * FROM users WHERE active = 1;'"
      class="query-textarea font-mono-code"
      :disabled="disabled"
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

// Props
interface Props {
  disabled?: boolean
}

defineProps<Props>()

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
  display: flex;
  flex-direction: column;
  height: 100%;
  border: 1px solid #27272a;
  border-radius: 0.25rem;
  background-color: #18181b;
}

.editor-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0.5rem 0.75rem;
  border-bottom: 1px solid #27272a;
}

.run-button {
  display: flex;
  align-items: center;
  padding: 0.25rem 0.5rem;
  font-size: 0.75rem;
  border-radius: 0.25rem;
  background-color: rgba(34, 197, 94, 0.1);
  color: #22c55e;
  border: 1px solid #22c55e;
  transition: all 150ms;
}

.run-button:hover {
  background-color: rgba(34, 197, 94, 0.2);
}

.run-button:focus {
  outline: none;
  box-shadow: 0 0 0 1px #4ade80;
}

.query-textarea {
  flex: 1;
  width: 100%;
  padding: 0.5rem 0.75rem;
  resize: none;
  background-color: #000000;
  color: #d1d5db;
  font-size: 0.75rem;
  line-height: 1.5;
}

.query-textarea::placeholder {
  color: #374151;
}

.query-textarea:focus {
  outline: none;
  box-shadow: 0 0 0 1px #facc15;
}

.query-textarea:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.editor-footer {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0.25rem 0.75rem;
  border-top: 1px solid #27272a;
  background-color: rgba(24, 24, 27, 0.5);
}
</style>
