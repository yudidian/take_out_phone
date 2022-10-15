import MyLoading from '@/components/MyLoading.vue'
import TasteSelection from '@/components/TasteSelection.vue'
export default {
  install (app) {
    app.component('MyLoading', MyLoading)
      .component('TasteSelection', TasteSelection)
  }
}
