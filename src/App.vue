<template>
  <router-view />
  <MyLoading :show="store.getters.showLoading" />
</template>
<script setup>
import { useStore } from 'vuex'
import { useRoute } from 'vue-router'
import { reactive, watch } from 'vue'
const store = useStore()
const includeRouter = reactive(['SettlementPage', 'LayoutPage', 'GoodsDetail'])
const route = useRoute()
watch(route, (value) => {
  if (value.name === 'AddressChoose' || value.name === 'settlement') {
    if (includeRouter.indexOf('SettlementPage') === -1) {
      includeRouter.push('SettlementPage')
    }
  } else {
    const index = includeRouter.findIndex(item => item === 'SettlementPage')
    index !== -1 && includeRouter.splice(index, 1)
  }
})
</script>

<style scoped>
.router_animate-enter-active {
  animation: slideInLeft 0.2s;
}
.router_animate-leave-active {
  animation: slideOutLeft 0.2s;
}
</style>
