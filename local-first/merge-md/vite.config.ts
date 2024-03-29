import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import wasm from 'vite-plugin-wasm'
import topLevelAwait from 'vite-plugin-top-level-await'

export default defineConfig({
  plugins: [topLevelAwait(), wasm(), react()],
  server: {
    port: 8080
  },
  worker: {
    format: 'es',
    // @ts-expect-error - vite-plugin-wasm is not yet compatible with worker-loader
    plugins: [wasm()]
  }
})
