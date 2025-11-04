<template>
  <header class="h-full flex items-center justify-between px-4 bg-zinc-100">
    <!-- Logo/Title -->
    <div class="flex items-center space-x-2">
      <div class="text-xs text-zinc-500">●</div>
      <h1 class="text-lg font-semibold tracking-tight text-zinc-950">
        <span class="text-yellow-400">Viz</span><span class="text-green-500">QL</span>
      </h1>
    </div>
    
    <!-- Actions -->
    <div class="flex items-center space-x-2">
      <button
        @click="$emit('connect-clicked')"
        class="header-btn text-green-500 border-green-500 hover:bg-green-500/10"
      >
        <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
        </svg>
        Connect
      </button>
      
      <button
        @click="$emit('settings-clicked')"
        class="header-btn text-zinc-600 border-zinc-400 hover:bg-zinc-200"
      >
        <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
        </svg>
        Settings
      </button>
    </div>
  </header>
</template>

<script setup lang="ts">
// Emits
defineEmits<{
  'connect-clicked': []
  'settings-clicked': []
}>()
</script>

<style scoped>
.header-btn {
  display: flex;
  align-items: center;
  padding: 0.25rem 0.5rem;
  font-size: 0.75rem;
  border-width: 1px;
  border-radius: 0.25rem;
  transition: all 150ms;
}

.header-btn:focus {
  outline: 2px solid #e8c547;
  outline-offset: 2px;
}
</style>
