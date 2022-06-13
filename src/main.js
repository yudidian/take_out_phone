import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import './style/common.css'
import 'amfe-flexible'
import '@vant/touch-emulator'
import './style/vant.css'
import components from '@/components'
const app = createApp(App)
app.use(router)
  .use(store)
  .use(components)
app.mount('#app')
