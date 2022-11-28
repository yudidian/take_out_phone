import MyLoading from '@/components/MyLoading.vue'
import TasteSelection from '@/components/TasteSelection.vue'
import CartList from '@/components/CartList.vue'
import ToTop from '@/components/ToTop.vue'
import { Dialog } from 'vant'
export default {
  install (app) {
    app
      .component('MyLoading', MyLoading)
      .component('TasteSelection', TasteSelection)
      .component('CartList', CartList)
      .component('ToTop', ToTop)
      .component('VanDialog', Dialog.Component)
  }
}
