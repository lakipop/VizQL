<template>
  <div class="page-container">
    <!-- Connection Modal -->
    <ConnectionModal
      :show="isModalOpen"
      @close="closeModal"
      @connect="handleConnection"
    />

    <!-- Query Editor Section -->
    <div class="query-section">
      <QueryEditor 
        @run-query="handleRunQuery"
        :disabled="!isConnected"
      />
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
        
        <!-- Connection Status -->
        <span v-if="isConnected" class="text-xxs text-green-500 flex items-center gap-1">
          <svg class="w-3 h-3" fill="currentColor" viewBox="0 0 20 20">
            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
          </svg>
          Connected
        </span>
        
        <!-- Loading Indicator -->
        <span v-if="isLoading" class="text-xxs text-yellow-500 flex items-center gap-1">
          <svg class="w-3 h-3 animate-spin" fill="none" viewBox="0 0 24 24">
            <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
            <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
          </svg>
          Loading...
        </span>
        
        <!-- Last Executed -->
        <span v-if="queryExecuted && !isLoading" class="text-xxs text-gray-600">
          Last executed: {{ lastExecutedTime }}
        </span>
      </div>
      
      <!-- Error Display -->
      <div v-if="queryError" class="error-banner">
        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
        </svg>
        <div>
          <p class="font-semibold">Query Error</p>
          <p class="text-xs">{{ queryError }}</p>
        </div>
        <button @click="queryError = null" class="ml-auto">
          <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
          </svg>
        </button>
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
import { ref } from 'vue'
import type { ConnectionDetails } from '~/composables/useConnection'

// Use the connection modal composable
const { isModalOpen, closeModal, setConnection, isConnected, connectionDetails } = useConnectionModal()

// State
const resultsData = ref<any[] | null>(null)
const showChart = ref(false)
const queryExecuted = ref(false)
const lastExecutedTime = ref('')
const isLoading = ref(false)
const queryError = ref<string | null>(null)

// Handle database connection
const handleConnection = async (details: ConnectionDetails) => {
  isLoading.value = true
  queryError.value = null

  try {
    // Call the API to get schema
    const response = await $fetch('/api/get-schema', {
      method: 'POST',
      body: { connectionDetails: details }
    })

    if (response.success && response.schema) {
      // Store connection details and schema in global state
      setConnection(details, response.schema)
      closeModal()
      
      console.log('Connected successfully! Tables:', response.tableCount)
    } else {
      throw new Error('Failed to retrieve database schema')
    }
  } catch (error: any) {
    console.error('Connection error:', error)
    queryError.value = error.data?.statusMessage || error.message || 'Connection failed'
  } finally {
    isLoading.value = false
  }
}

// Handle query execution
const handleRunQuery = async (query: string) => {
  if (!isConnected.value || !connectionDetails.value) {
    queryError.value = 'Please connect to a database first'
    return
  }

  isLoading.value = true
  queryError.value = null
  
  try {
    // Call the API to execute query
    const response = await $fetch('/api/execute-query', {
      method: 'POST',
      body: {
        connectionDetails: connectionDetails.value,
        sqlQuery: query
      }
    })

    if (response.success) {
      resultsData.value = response.data as any[]
      queryExecuted.value = true
      
      // Update timestamp
      const now = new Date()
      lastExecutedTime.value = now.toLocaleTimeString()
      
      console.log('Query executed successfully! Rows:', response.rowCount)
    } else {
      throw new Error('Query execution failed')
    }
  } catch (error: any) {
    console.error('Query error:', error)
    queryError.value = error.data?.statusMessage || error.message || 'Query execution failed'
    resultsData.value = null
  } finally {
    isLoading.value = false
  }
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

.error-banner {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 0.75rem;
  background-color: #fef2f2;
  border: 1px solid #fca5a5;
  border-radius: 0.25rem;
  color: #991b1b;
  font-size: 0.75rem;
  margin-bottom: 0.5rem;
}

.error-banner button {
  color: #dc2626;
  transition: color 150ms;
}

.error-banner button:hover {
  color: #991b1b;
}
</style>
