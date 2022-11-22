<template>
  <router-view v-slot="{ Component }">
    <keep-alive :include="['LayoutPage']">
      <component
        :is="Component"
        :key="$route.name"
      />
    </keep-alive>
  </router-view>
  <MyLoading :show="store.getters.showLoading" />
</template>
<script setup>
import { useStore } from 'vuex'
import { watch } from 'vue'
const store = useStore()
watch(store.getters.keepalive, (val) => {
  console.log(val)
})
</script>
