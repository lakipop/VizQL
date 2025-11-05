<template>
  <Teleport to="body">
    <Transition name="modal">
      <div v-if="show" class="modal-overlay" @click.self="handleClose">
        <div class="modal-container">
          <!-- Modal Header -->
          <div class="modal-header">
            <h3 class="text-sm font-semibold text-zinc-950">Database Connection</h3>
            <button @click="handleClose" class="close-btn">
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
          </div>

          <!-- Modal Body -->
          <div class="modal-body">
            <div class="form-group">
              <label for="host" class="form-label">Host</label>
              <input
                id="host"
                v-model="formData.host"
                type="text"
                placeholder="e.g., localhost, vizql-db"
                class="form-input"
                @keydown.enter="handleConnect"
              />
            </div>

            <div class="form-group">
              <label for="port" class="form-label">Port</label>
              <input
                id="port"
                v-model.number="formData.port"
                type="number"
                placeholder="3306"
                class="form-input"
                @keydown.enter="handleConnect"
              />
            </div>

            <div class="form-group">
              <label for="database" class="form-label">Database</label>
              <input
                id="database"
                v-model="formData.database"
                type="text"
                placeholder="vizql_db"
                class="form-input"
                @keydown.enter="handleConnect"
              />
            </div>

            <div class="form-group">
              <label for="user" class="form-label">User</label>
              <input
                id="user"
                v-model="formData.user"
                type="text"
                placeholder="vizql_user"
                class="form-input"
                @keydown.enter="handleConnect"
              />
            </div>

            <div class="form-group">
              <label for="password" class="form-label">Password</label>
              <input
                id="password"
                v-model="formData.password"
                type="password"
                placeholder="••••••••"
                class="form-input"
                @keydown.enter="handleConnect"
              />
            </div>

            <!-- Developer Note -->
            <div class="dev-note">
              <svg class="w-3 h-3 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
              <div>
                <p class="text-xxs font-semibold text-zinc-700">For Docker Setup:</p>
                <p class="text-xxs text-zinc-600">Host: <code>vizql-db</code> | Port: <code>3306</code> | DB: <code>vizql_db</code></p>
                <p class="text-xxs text-zinc-600">User: <code>vizql_user</code> | Pass: <code>vizql_pass</code></p>
              </div>
            </div>
          </div>

          <!-- Modal Footer -->
          <div class="modal-footer">
            <button @click="handleClose" class="btn btn-cancel">
              Cancel
            </button>
            <button @click="handleConnect" :disabled="!isFormValid" class="btn btn-connect">
              <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
              </svg>
              Connect
            </button>
          </div>
        </div>
      </div>
    </Transition>
  </Teleport>
</template>

<script setup lang="ts">
import { ref, computed, watch } from 'vue'
import type { ConnectionDetails } from '~/composables/useConnection'

// Props
interface Props {
  show: boolean
}

const props = defineProps<Props>()

// Emits
const emit = defineEmits<{
  close: []
  connect: [details: ConnectionDetails]
}>()

// Form data
const formData = ref<ConnectionDetails>({
  host: 'vizql-db',
  port: 3306,
  database: 'vizql_db',
  user: 'vizql_user',
  password: 'vizql_pass'
})

// Computed
const isFormValid = computed(() => {
  return (
    formData.value.host.trim() !== '' &&
    formData.value.port > 0 &&
    formData.value.database.trim() !== '' &&
    formData.value.user.trim() !== '' &&
    formData.value.password.trim() !== ''
  )
})

// Methods
const handleClose = () => {
  emit('close')
}

const handleConnect = () => {
  if (isFormValid.value) {
    emit('connect', formData.value)
  }
}

// Reset form when modal closes
watch(() => props.show, (newVal) => {
  if (!newVal) {
    // Keep the last values for convenience
  }
})
</script>

<style scoped>
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.7);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 9999;
  backdrop-filter: blur(2px);
}

.modal-container {
  background-color: #fafafa;
  border-radius: 0.5rem;
  box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.3), 0 10px 10px -5px rgba(0, 0, 0, 0.2);
  width: 90%;
  max-width: 420px;
  max-height: 90vh;
  overflow: hidden;
  display: flex;
  flex-direction: column;
}

.modal-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 1rem 1.25rem;
  border-bottom: 1px solid #e4e4e7;
  background-color: #ffffff;
}

.close-btn {
  color: #71717a;
  transition: color 150ms;
  padding: 0.25rem;
  border-radius: 0.25rem;
}

.close-btn:hover {
  color: #18181b;
  background-color: #f4f4f5;
}

.modal-body {
  padding: 1.25rem;
  overflow-y: auto;
  flex: 1;
}

.form-group {
  margin-bottom: 1rem;
}

.form-label {
  display: block;
  font-size: 0.75rem;
  font-weight: 600;
  color: #3f3f46;
  margin-bottom: 0.375rem;
}

.form-input {
  width: 100%;
  padding: 0.5rem 0.75rem;
  font-size: 0.75rem;
  border: 1px solid #d4d4d8;
  border-radius: 0.25rem;
  background-color: #ffffff;
  color: #18181b;
  transition: all 150ms;
}

.form-input:focus {
  outline: none;
  border-color: #22c55e;
  box-shadow: 0 0 0 3px rgba(34, 197, 94, 0.1);
}

.form-input::placeholder {
  color: #a1a1aa;
}

.dev-note {
  margin-top: 1.25rem;
  padding: 0.75rem;
  background-color: #dbeafe;
  border: 1px solid #93c5fd;
  border-radius: 0.25rem;
  display: flex;
  gap: 0.5rem;
}

.dev-note code {
  background-color: #1e293b;
  color: #22c55e;
  padding: 0.125rem 0.25rem;
  border-radius: 0.125rem;
  font-family: 'Courier New', monospace;
  font-size: 0.7rem;
}

.modal-footer {
  display: flex;
  align-items: center;
  justify-content: flex-end;
  gap: 0.5rem;
  padding: 1rem 1.25rem;
  border-top: 1px solid #e4e4e7;
  background-color: #fafafa;
}

.btn {
  display: flex;
  align-items: center;
  padding: 0.5rem 0.875rem;
  font-size: 0.75rem;
  font-weight: 500;
  border-radius: 0.25rem;
  transition: all 150ms;
  border: 1px solid transparent;
}

.btn:focus {
  outline: 2px solid #22c55e;
  outline-offset: 2px;
}

.btn-cancel {
  color: #52525b;
  border-color: #d4d4d8;
  background-color: #ffffff;
}

.btn-cancel:hover {
  background-color: #f4f4f5;
  border-color: #a1a1aa;
}

.btn-connect {
  color: #ffffff;
  background-color: #22c55e;
  border-color: #22c55e;
}

.btn-connect:hover {
  background-color: #16a34a;
}

.btn-connect:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

/* Modal transitions */
.modal-enter-active,
.modal-leave-active {
  transition: opacity 200ms ease;
}

.modal-enter-from,
.modal-leave-to {
  opacity: 0;
}

.modal-enter-active .modal-container,
.modal-leave-active .modal-container {
  transition: transform 200ms ease;
}

.modal-enter-from .modal-container,
.modal-leave-to .modal-container {
  transform: scale(0.95);
}
</style>
