<template>
  <RouterView v-slot="{ Component }">
    <keep-alive>
      <component
        :is="Component"
        v-if="$route.meta.keepAlive"
      />
    </keep-alive>
    <component
      :is="Component"
      v-if="!$route.meta.keepAlive"
    />
  </RouterView>
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
import { onMounted, ref, watch } from 'vue'
const active = ref('home')
const route = useRoute()
watch(route, (val) => {
  active.value = val.name
})
onMounted(() => {
  active.value = route.name
})
const tabChangeHandler = (val) => {
  active.value = val
}
</script>

<style scoped>

</style>
