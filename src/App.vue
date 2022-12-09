<template>
  <router-view
    v-slot="{ Component }"
    v-if="isWeChat"
  >
    <keep-alive :include="store.getters.parentKeepalive">
      <component
        :is="Component"
        :key="$route.name"
      />
    </keep-alive>
  </router-view>
  <div
    v-else
    class="error-open"
  >
    <img
      src="./assets/image/false.png"
      alt=""
    >
    <p>请在手机微信客户端打开链接</p>
  </div>
  <MyLoading :show="store.getters.showLoading" />
</template>
<script setup>
import { useStore } from 'vuex'
import { isWeiXin } from '@/utils/common'
import { ref } from 'vue'
import SocketService from '@/utils/websocket'
const WEB_SOCKET_URL = import.meta.env.DEV ? import.meta.env.VITE_LOCAL_WEBSOCK : import.meta.env.VITE_SERVER_WEBSOCK
const store = useStore()
const isWeChat = ref(isWeiXin())
const init = () => {
  if (store.getters.token) {
    if (localStorage.getItem('reload') === null) {
      console.log(localStorage.getItem('reload'))
      localStorage.setItem('reload', 'true')
      window.location.reload()
      return
    }
    if (localStorage.getItem('reload') === 'true') {
      localStorage.setItem('reload', 'false')
      window.location.reload()
      return
    }
    console.log(store.getters.userId)
    const socket = new SocketService(`${WEB_SOCKET_URL}/websocket?userId=${store.getters.userId}`)
    socket.getMessage()
  }
}
init()
</script>
<style lang="scss" scoped>
.error-open {
  position: relative;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  display: flex;
  align-items: center;
  flex-direction: column;
  justify-content: center;

  img {
    width: 50px;
    margin-bottom: 10px;
  }

  p {
    font-size: 22px;
    font-weight: 900;
  }
}
</style>
