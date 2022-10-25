import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import Mitt from 'mitt'
import './style/common.css'
import 'amfe-flexible'
import '@vant/touch-emulator'
import './style/vant.css'
import components from '@/components'
import VueAMap, { initAMapApiLoader } from '@vuemap/vue-amap'
import '@vuemap/vue-amap/dist/style.css'
import '@/assets/font/iconfont.css'
import 'animate.css/animate.min.css'
initAMapApiLoader({
  key: '21ff8a3c52132e33add0ca88b4d58507'
})
const app = createApp(App)
app.config.globalProperties.$bus = new Mitt()
app.use(router).use(store).use(components).use(VueAMap)
app.mount('#app')
