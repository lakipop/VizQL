<template>
  <div class="visualizer-container">
    <div class="chart-header">
      <h3 class="text-xs font-semibold text-gray-400">Data Visualization</h3>
      <span class="text-xxs text-gray-600">Bar Chart</span>
    </div>
    
    <div class="chart-wrapper">
      <Bar :data="chartData" :options="chartOptions" />
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { Bar } from 'vue-chartjs'
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  BarElement,
  Title,
  Tooltip,
  Legend
} from 'chart.js'

// Register ChartJS components
ChartJS.register(
  CategoryScale,
  LinearScale,
  BarElement,
  Title,
  Tooltip,
  Legend
)

// Props
interface Props {
  data?: any[] | null
}

const props = defineProps<Props>()

// Chart data (mock for Phase 1)
const chartData = computed(() => {
  // If data is provided, use it; otherwise use mock data
  const dataSource = props.data || [
    { id: 1, name: 'Product A', sales: 1250, region: 'North' },
    { id: 2, name: 'Product B', sales: 890, region: 'South' },
    { id: 3, name: 'Product C', sales: 1560, region: 'East' },
    { id: 4, name: 'Product D', sales: 720, region: 'West' },
    { id: 5, name: 'Product E', sales: 1340, region: 'North' }
  ]

  return {
    labels: dataSource.map(item => item.name || item.id),
    datasets: [
      {
        label: 'Sales',
        data: dataSource.map(item => item.sales || 0),
        backgroundColor: 'rgba(107, 155, 110, 0.6)', // Matte green
        borderColor: 'rgba(107, 155, 110, 1)',
        borderWidth: 1
      }
    ]
  }
})

// Chart options
const chartOptions = computed(() => ({
  responsive: true,
  maintainAspectRatio: false,
  plugins: {
    legend: {
      display: true,
      position: 'top' as const,
      labels: {
        color: '#d1d5db', // Gray-300
        font: {
          size: 10
        },
        padding: 10
      }
    },
    tooltip: {
      backgroundColor: 'rgba(17, 24, 39, 0.95)', // Gray-900
      titleColor: '#e8c547', // Yellow
      bodyColor: '#d1d5db', // Gray-300
      borderColor: '#374151', // Gray-700
      borderWidth: 1,
      padding: 8,
      titleFont: {
        size: 11
      },
      bodyFont: {
        size: 10
      }
    }
  },
  scales: {
    x: {
      ticks: {
        color: '#9ca3af', // Gray-400
        font: {
          size: 9
        }
      },
      grid: {
        color: 'rgba(55, 65, 81, 0.3)', // Gray-700 with transparency
        borderColor: '#4b5563' // Gray-600
      }
    },
    y: {
      ticks: {
        color: '#9ca3af', // Gray-400
        font: {
          size: 9
        }
      },
      grid: {
        color: 'rgba(55, 65, 81, 0.3)', // Gray-700 with transparency
        borderColor: '#4b5563' // Gray-600
      }
    }
  }
}))
</script>

<style scoped>
.visualizer-container {
  @apply flex flex-col h-full border border-gray-800 rounded bg-gray-900;
}

.chart-header {
  @apply flex items-center justify-between px-3 py-2 border-b border-gray-800;
}

.chart-wrapper {
  @apply flex-1 p-4 overflow-hidden;
  min-height: 300px;
}
</style>
