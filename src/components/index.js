import MyLoading from '@/components/MyLoading.vue'
import MyDialog from '@/components/My-dialog.vue'
export default {
  install (app) {
    app.component('MyLoading', MyLoading)
      .component('MyDialog', MyDialog)
  }
}
