<template>
  <router-view v-slot="{ Component }">
    <keep-alive :include="store.getters.parentKeepalive">
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
const store = useStore()
</script>
