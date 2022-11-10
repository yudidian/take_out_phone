<template>
  <router-view v-slot="{ Component }">
    <transition name="router_animate">
      <keep-alive :include="store.getters.keepalive">
        <component
          :is="Component"
          :key="$route.name"
        />
      </keep-alive>
    </transition>
  </router-view>
  <MyLoading :show="store.getters.showLoading" />
</template>
<script setup>
import { useStore } from 'vuex'
const store = useStore()
</script>

<style scoped>
.router_animate-enter-active {
  animation: slideInLeft 0.2s;
}
.router_animate-leave-active {
  animation: slideOutLeft 0.2s;
}
</style>
