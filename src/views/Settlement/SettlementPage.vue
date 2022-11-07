<template>
  <div>
    <ConfigProvider :theme-vars="themeVars">
      <div class="settlement-wrapper">
        <NavBar
          title="提交订单"
          left-arrow
          @click-left="$router.back()"
        />
        <OrderList
          ref="orderList"
          @get-price="allPrice = $event"
        />
        <SubmitBar
          :price="allPrice"
          button-text="提交订单"
          @submit="onSubmit"
        />
      </div>
    </configprovider>
  </div>
</template>

<script setup name="SettlementPage">
import OrderList from './component/OrderList.vue'
import { sendSubmitOrders } from '@/api/module/orders.js'
import { NavBar, ConfigProvider, SubmitBar, Toast, Dialog } from 'vant'
import { ref } from 'vue'
import { useRouter } from 'vue-router'
const orderList = ref(null)
const allPrice = ref(0)
const router = useRouter()
// 内的值会被转换成对应 CSS 变量
// 比如 sliderBarHeight 会转换成 `--van-slider-bar-height`
const themeVars = {
  navBarBackgroundColor: 'transparent',
  navBarIconColor: '#000'
}
// 提交信息
const onSubmit = () => {
  Dialog.alert({
    title: '用户需知',
    message: '本网站仅供学习使用，下单不会有任何实际效果！'
  }).then(async () => {
    const res = await sendSubmitOrders(orderList.value.sendInfo)
    if (res.code === 1) {
      Toast.success(res.msg)
      await router.replace('/mine')
    } else {
      Toast.fail(res.msg)
    }
  })
}
</script>

<style scoped lang="scss">
@import "@/style/util.scss";
.settlement-wrapper {
  width: 100%;
  height: 100vh;
  background: linear-gradient($main-color 0%, #f8f6f6 40%, #f8f6f6 100%);
}
</style>
