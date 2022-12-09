<template>
  <div class="chart-wrapper">
    <NavBar
      title="客服中心"
      left-arrow
      @click-left="$router.back()"
    />
    <div
      class="message-content"
      ref="messageContent"
    >
      <Empty
        v-if="messageList.length === 0"
        :image="IMG_URL+'empty.png'"
        description="暂无消息"
      />
      <div
        v-else
        class="message-item"
        v-for="item in messageList"
        :key="item.id"
      >
        <div
          v-if="item.managerName !== undefined"
          class="left-review"
        >
          <img :src="IMG_URL + item.managerAvatar">
          <div class="review-right">
            <span class="review-name">{{ item.managerName }}</span>
            <span class="review-message">
              {{ item.message }}
            </span>
            <span class="review-time"> {{ formatDate(item.createTime) }}</span>
          </div>
        </div>
        <div
          class="right-review"
          v-else
        >
          <div class="review-right">
            <span class="review-name">{{ item.userName }}</span>
            <span class="review-message">
              {{ item.message }}
            </span>
            <span class="review-time"> {{ formatDate(item.createTime) }}</span>
          </div>
          <img :src="IMG_URL + item.userAvatar">
        </div>
      </div>
    </div>
    <div class="bottom">
      <Field
        v-model="message"
        type="textarea"
        center
        clearable
        placeholder="请输入内容"
      >
        <template #button>
          <Button
            size="small"
            type="primary"
            @click="sendMessage"
          >
            发送
          </Button>
        </template>
      </Field>
    </div>
  </div>
</template>

<script name="CustomerService" setup>
import { NavBar, Field, Button, Empty } from 'vant'
import SocketService from '@/utils/websocket'
import { formatDate } from '@/utils/common'
import { useStore } from 'vuex'
import { nextTick, onMounted, ref, watch } from 'vue'
const messageContent = ref()
const IMG_URL = import.meta.env.VITE_LOCAL_SERVE_IMGE_URL
const WEB_SOCKET_URL = import.meta.env.DEV ? import.meta.env.VITE_LOCAL_WEBSOCK : import.meta.env.VITE_SERVER_WEBSOCK
const store = useStore()
const socket = ref(null)
const message = ref('')
const messageList = ref([])
const init = () => {
  socket.value = new SocketService(`${WEB_SOCKET_URL}/websocket/chart?userId=${store.getters.userId}`)
  socket.value.ws.onmessage = msg => {
    messageList.value = JSON.parse(msg.data)
  }
  nextTick(() => {
    messageContent.value.scrollTop = messageContent.value.scrollHeight
  })
}
onMounted(() => {
  init()
})
watch(messageList, () => {
  nextTick(() => {
    messageContent.value.scrollTop = messageContent.value.scrollHeight
  })
})
const sendMessage = () => {
  socket.value.send({
    message: message.value,
    userId: store.getters.userId
  })
  message.value = ''
}
</script>

<style scoped lang="scss">
.chart-wrapper{
  position: relative;
  height: 100vh;
  .message-content{
    width: 100%;
    height: calc(100vh - 46px - 80px);
    overflow-y: auto;
      .message-item{
        display: flex;
        margin-bottom: 10px;
        .left-review{
          margin-left: 10px;
          justify-self: flex-start;
          width: 100%;
          height: auto;
          display: flex;
          align-items: center;
          justify-content: flex-start;
          img{
            width: 40px;
            height: 40px;
            margin-right: 10px;
          }
          .review-right {
            width: 70%;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: flex-start;
            .review-name{
              font-size: 12px;
              font-weight: 900;
            }
            .review-message{
              padding: 10px;
              font-size: 14px;
              background-color: #eeeeee;
              border-radius: 5px;
              overflow-wrap: anywhere;
            }
            .review-time{
              font-size: 12px;
            }
          }
        }
        .right-review{
          margin-right: 10px;
          width: 100%;
          height: auto;
          display: flex;
          align-items: center;
          margin-left: auto;
          justify-content: flex-end;
          img{
            width: 40px;
            height: 40px;
            margin-left: 10px;
          }
          .review-right {
            width: 70%;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: flex-end;
            .review-name{
              font-weight: 900;
              font-size: 12px;
            }
            .review-message{
              padding: 10px;
              font-size: 14px;
              background-color: #eeeeee;
              border-radius: 5px;
              overflow-wrap: anywhere;
            }
            .review-time{
              font-size: 12px;
            }
          }
        }
    }
  }
  .bottom {
    width: 100%;
    position: absolute;
    bottom: 0;
  }
}
</style>
