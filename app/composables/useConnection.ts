export interface ConnectionDetails {
  host: string
  port: number
  database: string
  user: string
  password: string
}

interface ConnectionState {
  isModalOpen: boolean
  isConnected: boolean
  connectionDetails: ConnectionDetails | null
  schema: Record<string, string[]> | null
}

const state = reactive<ConnectionState>({
  isModalOpen: false,
  isConnected: false,
  connectionDetails: null,
  schema: null
})

export const useConnectionModal = () => {
  const openModal = () => {
    state.isModalOpen = true
  }

  const closeModal = () => {
    state.isModalOpen = false
  }

  const setConnection = (details: ConnectionDetails, schema: Record<string, string[]>) => {
    state.connectionDetails = details
    state.schema = schema
    state.isConnected = true
  }

  const disconnect = () => {
    state.connectionDetails = null
    state.schema = null
    state.isConnected = false
  }

  return {
    isModalOpen: computed(() => state.isModalOpen),
    isConnected: computed(() => state.isConnected),
    connectionDetails: computed(() => state.connectionDetails),
    schema: computed(() => state.schema),
    openModal,
    closeModal,
    setConnection,
    disconnect
  }
}
