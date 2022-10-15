<template>
  <router-view />
  <MyLoading :show="store.getters.showLoading" />
</template>
<script setup>
import { useStore } from 'vuex'
const store = useStore()
</script>
