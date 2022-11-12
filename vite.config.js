import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import eslintPlugin from 'vite-plugin-eslint'
import styleImport, { VantResolve } from 'vite-plugin-style-import'
import VueSetupExtend from 'vite-plugin-vue-setup-extend'
import path from 'path'

export default defineConfig({
  plugins: [
    vue(),
    VueSetupExtend(),
    eslintPlugin({
      cache: false
    }),
    styleImport({
      resolves: [VantResolve()],
      libs: [
        {
          libraryName: 'vant',
          esModule: true,
          resolveStyle: name => `../es/${name}/style`
        }
      ]
    })
  ],
  resolve: {
    alias: {
      '@': path.join(__dirname, 'src')
    }
  },
  server: {
    proxy: {
      '/api': {
        target: 'http://localhost:8089',
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api/, '')
      }
    }
  },
  build: {
    outDir: 'dist',
    minify: 'esbuild'
  }
})
