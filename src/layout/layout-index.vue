<template>
  <RouterView />
  <Tabbar
    v-model="active"
    router
    @change="tabChangeHandler"
  >
    <TabbarItem
      name="home"
      to="/home"
      icon="home-o"
    >
      首页
    </TabbarItem>
    <TabbarItem
      name="cart"
      to="/cart"
      icon="cart-o"
    >
      购物车
    </TabbarItem>
    <TabbarItem
      name="mine"
      icon="user-o"
      to="/mine"
    >
      我的
    </TabbarItem>
  </Tabbar>
</template>
<script setup>
import { Tabbar, TabbarItem } from 'vant'
import { useRoute } from 'vue-router'
import { onMounted, ref } from 'vue'
const active = ref('home')
const route = useRoute()
onMounted(() => {
  active.value = route.meta.index
})
const tabChangeHandler = (val) => {
  active.value = val
}
</script>

<style scoped>

</style>
