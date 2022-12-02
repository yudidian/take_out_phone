<template>
  <section>
    <RouterView v-slot="{ Component }">
      <keep-alive :include="store.getters.childKeepalive">
        <component
          :is="Component"
        />
      </keep-alive>
    </RouterView>
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
import { onBeforeUnmount, onMounted, ref, watch } from 'vue'
import { useStore } from 'vuex'
import SocketService from '@/utils/websocket'
const store = useStore()
const active = ref('HomePage')
const route = useRoute()
watch(route, (val) => {
  active.value = val.name
})

onMounted(() => {
  active.value = route.name
})
onBeforeUnmount(() => {
  localStorage.setItem('reload', 'true')
})
const tabChangeHandler = (val) => {
  active.value = val
}
const init = () => {
  if (store.getters.token) {
    if (localStorage.getItem('reload') === null) {
      console.log(localStorage.getItem('reload'))
      localStorage.setItem('reload', 'true')
      window.location.reload()
      return
    }
    if (localStorage.getItem('reload') === 'true') {
      console.log(localStorage.getItem('reload'))
      localStorage.setItem('reload', 'false')
      window.location.reload()
      return
    }
    const socket = new SocketService()
    socket.send({
      userId: store.getters.userId
    })
    socket.getMessage()
  }
}
init()
</script>

<style scoped></style>
