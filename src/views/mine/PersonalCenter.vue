<template>
  <div class="wrapper">
    <header>
      <p class="title">
        个人中心
      </p>
      <div class="user">
        <div class="img-wrapper">
          <img
            alt="用户头像"
            v-if="!userInfo.avatar"
            src="@/assets/image/headPage.png"
          >
          <img
            alt="用户头像"
            v-else
            :src="BASE_IMGE_URL + userInfo.avatar"
            @click="ImagePreview([BASE_IMGE_URL + userInfo.avatar])"
            crossOrigin="anonymous"
          >
        </div>
        <span class="user-name">{{ userInfo.name }}</span>
        <img
          v-if="userInfo.sex === '1'"
          src="@/assets/image/woman.png"
          class="user-icon"
          alt="用户头像"
        >
        <img
          v-else
          src="@/assets/image/man.png"
          class="user-icon"
          alt="用户头像"
        >
      </div>
    </header>
    <article>
      <section>
        <CellGroup inset>
          <Cell
            is-link
            to="/pendingReceipt"
          >
            <template #title>
              <Badge
                :content="orderSize"
                max="99"
              >
                <Icon
                  name="shop-collect-o"
                  size="16"
                />
                <span class="custom-title">待收货</span>
              </Badge>
            </template>
          </Cell>
          <Cell
            icon="star-o"
            title="我的收藏"
            is-link
            to="/storeUp"
          />
          <Cell
            icon="records"
            title="历史订单"
            is-link
            to="/history/orders"
          />
        </CellGroup>
      </section>
      <section>
        <CellGroup inset>
          <Cell
            title="最新订单"
            style="height: 285px"
          >
            <template #label>
              <LatestOrder :latest-order-list="latestOrderList" />
            </template>
          </Cell>
        </CellGroup>
      </section>
      <section>
        <Icon
          name="setting-o"
          class="btn-exit"
          @click="$router.push('/setting')"
        />
      </section>
    </article>
  </div>
</template>

<script setup name="PersonalCenter">
import { CellGroup, Cell, Toast, Icon, Badge, ImagePreview } from 'vant'
import { onMounted, ref } from 'vue'
import { sendGetNewOrders, sendGetUserInfo, sendPendingReceipt } from '@/api/module/user'
import LatestOrder from './components/LatestOrder.vue'
const BASE_IMGE_URL = import.meta.env.VITE_LOCAL_SERVE_IMGE_URL
const userInfo = ref({})
const latestOrderList = ref([])
const orderSize = ref(0)
onMounted(() => {
  getUserInfo()
  getNewOrders()
  getPendingReceipt()
})
// 获取最新订单
const getNewOrders = async () => {
  const res = await sendGetNewOrders()
  if (res.code === 1) {
    latestOrderList.value = res.info ?? []
  }
}
// 获取用户信息
const getUserInfo = async () => {
  const res = await sendGetUserInfo()
  if (res.code === 1) {
    userInfo.value = res.info
  } else {
    Toast.fail('用户信息获取失败')
  }
}
// 获取待收货数量
const getPendingReceipt = async () => {
  const res = await sendPendingReceipt()
  if (res.code === 1) {
    orderSize.value = res.data.size
  } else {
    Toast.fail('信息获取失败')
  }
}
</script>

<style scoped lang="scss">
.wrapper {
  width: 100vw;
  height: 100vh;
  background-color: #f3f2f7;
  header {
    width: 375px;
    height: 164px;
    background-color: #ffc200;
    .title {
      padding-top: 40px;
      font-size: 18px;
      font-weight: 700;
      text-align: center;
    }
    .user {
      display: flex;
      align-items: center;
      padding-top: 20px;
      .img-wrapper {
        width: 58px;
        height: 58px;
        margin-left: 20px;
        border-radius: 50%;
        img {
          width: 58px;
          height: 58px;
        }
      }
      .user-name {
        padding: 0 10px;
        font-size: 16px;
      }
      .user-icon {
        width: 30px;
        height: 30px;
      }
    }
  }
  article {
    margin-top: 20px;
    section {
      margin-top: 10px;
      .content {
        height: 200px;
      }
      .description {
        text-align: right;
      }
      .btn-exit {
        position: absolute;
        top: 17px;
        right: 4px;
        width: 40px;
        height: 40px;
      }
    }
  }
}
</style>
