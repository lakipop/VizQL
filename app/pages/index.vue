<template>
  <div class="page-container">
    <!-- Query Editor Section -->
    <div class="query-section">
      <QueryEditor @run-query="handleRunQuery" />
    </div>
    
    <!-- Results Section -->
    <div class="results-section">
      <div class="results-controls">
        <button
          @click="showChart = false"
          :class="['view-toggle-btn', { 'active': !showChart }]"
        >
          <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M3 14h18m-9-4v8m-7 0h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v8a2 2 0 002 2z" />
          </svg>
          Table
        </button>
        
        <button
          @click="showChart = true"
          :class="['view-toggle-btn', { 'active': showChart }]"
        >
          <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
          </svg>
          Chart
        </button>
        
        <div class="flex-1"></div>
        
        <span v-if="queryExecuted" class="text-xxs text-gray-600">
          Last executed: {{ lastExecutedTime }}
        </span>
      </div>
      
      <!-- Conditional Rendering: Table or Chart -->
      <div class="results-display">
        <ResultsTable v-if="!showChart" :data="resultsData" />
        <DataVisualizer v-else :data="resultsData" />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'

// State
const resultsData = ref<any[] | null>(null)
const showChart = ref(false)
const queryText = ref('')
const queryExecuted = ref(false)
const lastExecutedTime = ref('')

// Mock data
const MOCK_DATA = [
  { id: 1, name: 'Product A', sales: 1250, region: 'North', category: 'Electronics' },
  { id: 2, name: 'Product B', sales: 890, region: 'South', category: 'Home' },
  { id: 3, name: 'Product C', sales: 1560, region: 'East', category: 'Electronics' },
  { id: 4, name: 'Product D', sales: 720, region: 'West', category: 'Outdoor' },
  { id: 5, name: 'Product E', sales: 1340, region: 'North', category: 'Home' },
  { id: 6, name: 'Product F', sales: 980, region: 'South', category: 'Outdoor' },
  { id: 7, name: 'Product G', sales: 1120, region: 'East', category: 'Electronics' },
]

// Methods
const handleRunQuery = (query: string) => {
  console.log('Executing query:', query)
  
  // Store query text
  queryText.value = query
  
  // Simulate query execution with mock data
  resultsData.value = MOCK_DATA
  queryExecuted.value = true
  
  // Update timestamp
  const now = new Date()
  lastExecutedTime.value = now.toLocaleTimeString()
  
  // Log for development
  console.log('Mock data returned:', resultsData.value)
}

const toggleView = () => {
  showChart.value = !showChart.value
}
</script>

<style scoped>
.page-container {
  height: 100%;
  display: flex;
  flex-direction: column;
  padding: 1rem;
  gap: 1rem;
  background-color: #09090b;
}

.query-section {
  height: 50%;
}

.results-section {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.results-controls {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0 0.25rem;
}

.view-toggle-btn {
  display: flex;
  align-items: center;
  padding: 0.25rem 0.5rem;
  font-size: 0.75rem;
  border-radius: 0.25rem;
  border: 1px solid #3f3f46;
  color: #a1a1aa;
  transition: all 150ms;
}

.view-toggle-btn:hover {
  background-color: #27272a;
  color: #e4e4e7;
}

.view-toggle-btn:focus {
  outline: 2px solid #e8c547;
  outline-offset: 2px;
}

.view-toggle-btn.active {
  background-color: #fef3c7;
  border-color: #e8c547;
  color: #ca8a04;
}

.results-display {
  flex: 1;
  overflow: hidden;
}
</style>
