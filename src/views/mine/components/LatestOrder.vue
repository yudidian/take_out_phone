<template>
  <Empty
    image="https://fastly.jsdelivr.net/npm/@vant/assets/custom-empty-image.png"
    image-size="80"
    description="描述文字"
    v-if="latestOrderList.length === 0"
  />
  <div
    class="content"
    v-else
  >
    <div class="orders">
      <div class="orders-title">
        订单号:
      </div>
      <span class="orders-id">
        {{ latestOrderList[0].orderId }}
      </span>
      <Icon
        name="orders-o"
        size="20px"
        @click="copyOrderId(latestOrderList[0].orderId)"
      />
    </div>
    <ul class="order-wrapper">
      <li
        class="order-item"
        v-for="item in latestOrderList"
        :key="item.id"
      >
        <Image
          width="1.2rem"
          height="1.2rem"
          fit="cover"
          :src="BASE_IMGE_URL+item.image"
        />
        <div class="order-name">
          {{ item.name }}
        </div>
        <div class="order-num">
          <span class="number-logo">
            x
          </span>
          <span class="count">{{ item.number }}</span>
        </div>
      </li>
    </ul>
    <p class="description">
      共<span style="color:red;">{{ allCount }}</span>件商品，实付<span style="color:red;">{{ (price / 100).toFixed(2) }}</span>￥
    </p>
  </div>
</template>

<script setup name="LatestOrder">
import useClipboard from 'vue-clipboard3'
import { Image, Icon, Toast, Empty } from 'vant'
import { computed } from 'vue'
const { toClipboard } = useClipboard()
const BASE_IMGE_URL = import.meta.env.VITE_LOCAL_SERVE_IMGE_URL
const props = defineProps({
  latestOrderList: {
    type: Array,
    default: () => []
  }
})
const copyOrderId = async (id) => {
  try {
    await toClipboard(id)
    Toast('订单号复制成功')
  } catch (e) {
    Toast(e.message)
  }
}
const allCount = computed(() => {
  return props.latestOrderList.reduce((pre, item) => {
    return pre + item.number
  }, 0)
})
const price = computed(() => {
  return props.latestOrderList.reduce((pre, item) => {
    return pre + (item.number * item.amount)
  }, 0)
})
</script>

<style scoped lang="scss">
.content {
  height: 300px;
  .orders{
    display: flex;
    margin-top: 10px;
    margin-bottom: 10px;
    .orders-id{
      margin-left: 10px;
      margin-right: 10px;
    }
    .orders-title{
      color: black;
    }
  }
  .order-wrapper{
    height: 160px;
    overflow-y: auto;
    .order-item{
      margin-bottom: 10px;
      display: flex;
      justify-content: flex-start;
      align-items: center;
      .van-image{
        overflow: hidden;
        border-radius: 10px;
      }
      .order-name{
        margin-left: 20px;
      }
      .order-num{
        margin-left: auto;
        margin-right: 20px;
        .number-logo{
          font-size: 12px;
        }
        .count{
          font-size: 14px;
        }
      }
    }
  }
}
.description {
  margin-top: 16px;
  text-align: right;
}
</style>
