<template>
  <section>
    <RouterView v-slot="{ Component }">
      <keep-alive :include="['HomePage']">
        <component
          :is="Component"
          :key="$route.name"
        />
      </keep-alive>
    </RouterView>
    <div>{{ $route.name }}</div>
    <Tabbar
      v-model="active"
      router
      @change="tabChangeHandler"
    >
      <TabbarItem
        name="HomePage"
        to="/home"
        icon="home-o"
      >
        首页
      </TabbarItem>
      <TabbarItem
        name="CartPage"
        to="/cart"
        icon="cart-o"
      >
        购物车
      </TabbarItem>
      <TabbarItem
        name="PersonalCenter"
        icon="user-o"
        to="/mine"
      >
        我的
      </TabbarItem>
    </Tabbar>
  </section>
</template>
<script setup name="LayoutPage">
import { Tabbar, TabbarItem } from 'vant'
import { useRoute } from 'vue-router'
import { onMounted, ref, watch } from 'vue'
const active = ref('HomePage')
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

<style scoped></style>
