<template>
  <div class="app-container h-screen w-screen overflow-hidden bg-gray-900 text-gray-300">
    <!-- Header -->
    <div class="header-area border-b border-gray-700">
      <AppHeader 
        @connect-clicked="handleConnect"
        @settings-clicked="handleSettings"
      />
    </div>
    
    <!-- Main Layout: 3 columns -->
    <div class="main-layout">
      <!-- Left Sidebar -->
      <div class="sidebar-left border-r border-gray-700 bg-gray-900">
        <SidebarLeft @navigate="handleNavigate" />
      </div>
      
      <!-- Main Content Area -->
      <div class="content-area bg-black overflow-auto">
        <NuxtPage />
      </div>
      
      <!-- Right Sidebar -->
      <div class="sidebar-right border-l border-gray-700 bg-gray-900">
        <SidebarRight />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
// Event handlers for header actions
const handleConnect = () => {
  console.log('Connect clicked - will implement in Phase 2')
}

const handleSettings = () => {
  console.log('Settings clicked - will implement in Phase 2')
}

const handleNavigate = (destination: string) => {
  console.log(`Navigate to: ${destination}`)
}
</script>

<style scoped>
.app-container {
  display: flex;
  flex-direction: column;
}

.header-area {
  height: 48px;
  flex-shrink: 0;
}

.main-layout {
  display: grid;
  grid-template-columns: 180px 1fr 220px;
  height: calc(100vh - 48px);
  overflow: hidden;
}

.sidebar-left {
  overflow-y: auto;
  overflow-x: hidden;
}

.content-area {
  overflow-y: auto;
  overflow-x: hidden;
}

.sidebar-right {
  overflow-y: auto;
  overflow-x: hidden;
}

@media (max-width: 1024px) {
  .main-layout {
    grid-template-columns: 160px 1fr 200px;
  }
}

@media (max-width: 768px) {
  .main-layout {
    grid-template-columns: 140px 1fr 180px;
  }
}
</style>
