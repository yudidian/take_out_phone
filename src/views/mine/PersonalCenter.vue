<template>
  <div class="wrapper">
    <header @click="$router.push('/user/setting')">
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
            icon="guide-o"
            title="地址管理"
            is-link
            to="/address"
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
          <Cell title="最新订单">
            <template #label>
              <div class="content">
                xxxxxxxxxxxxxx
              </div>
              <p class="description">
                共0件商品，实付0￥
              </p>
            </template>
          </Cell>
        </CellGroup>
      </section>
      <section>
        <CellGroup
          inset
          class="btn-exit"
        >
          <button class="exit-out">
            退出登录
          </button>
        </CellGroup>
      </section>
    </article>
  </div>
</template>

<script setup name="PersonalCenter">
import { CellGroup, Cell, Toast } from 'vant'
import { onMounted, ref } from 'vue'
import { sendGetNewOrders, sendGetUserInfo } from '@/api/module/user'
const BASE_IMGE_URL = import.meta.env.VITE_LOCAL_SERVE_IMGE_URL
const userInfo = ref({})
onMounted(() => {
  getUserInfo()
  getNewOrders()
})
const getNewOrders = async () => {
  const res = await sendGetNewOrders()
  console.log(res)
}
const getUserInfo = async () => {
  const res = await sendGetUserInfo()
  console.log(res)
  if (res.code === 1) {
    userInfo.value = res.info
  } else {
    Toast.fail('用户信息获取失败')
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
        display: flex;
        justify-content: center;
        height: 40px;
        .exit-out {
          background-color: #fff;
          border: none;
          font-size: 16px;
        }
      }
    }
  }
}
</style>
