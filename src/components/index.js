import MyLoading from '@/components/My-loading.vue'
import MyDialog from '@/components/My-dialog.vue'
export default {
  install (app) {
    app.component('MyLoading', MyLoading)
      .component('MyDialog', MyDialog)
  }
}
