import type { Config } from 'tailwindcss'

export default <Partial<Config>>{
  content: [
    './components/**/*.{js,vue,ts}',
    './layouts/**/*.vue',
    './pages/**/*.vue',
    './plugins/**/*.{js,ts}',
    './app.vue',
  ],
  theme: {
    extend: {
      colors: {
        // Matte professional palette
        'vizql': {
          'dark': '#0a0a0a',
          'darker': '#050505',
          'gray': {
            '900': '#111827',
            '800': '#1f2937',
            '700': '#374151',
            '600': '#4b5563',
            '500': '#6b7280',
            '400': '#9ca3af',
            '300': '#d1d5db',
          },
          'yellow': {
            '400': '#e8c547',
            '500': '#d4af37',
          },
          'green': {
            '400': '#6b9b6e',
            '500': '#5a8a5d',
          }
        }
      },
      fontSize: {
        'xxs': '0.625rem',   // 10px - extra compact
        'xs': '0.75rem',      // 12px - compact
        'sm': '0.875rem',     // 14px - small
        'base': '0.875rem',   // 14px - base is small for tool feel
      },
      spacing: {
        '0.5': '0.125rem',
        '1': '0.25rem',
        '1.5': '0.375rem',
        '2': '0.5rem',
        '2.5': '0.625rem',
        '3': '0.75rem',
      },
      borderWidth: {
        'thin': '0.5px',
        'DEFAULT': '1px',
      }
    },
  },
  plugins: [],
}
