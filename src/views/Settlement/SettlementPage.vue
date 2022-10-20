<template>
  <div>
    <ConfigProvider :theme-vars="themeVars">
      <div class="settlement-wrapper">
        <NavBar title="提交订单" left-arrow @click-left="$router.back()" />
        <OrderList @get-price="allPrice = $event" />
        <SubmitBar
          :price="allPrice"
          button-text="提交订单"
          @submit="onSubmit"
        />
      </div>
    </ConfigProvider>
  </div>
</template>

<script setup name="SettlementPage">
import OrderList from "./component/OrderList.vue";
import { NavBar, ConfigProvider, SubmitBar } from "vant";
import { ref } from "vue";
const allPrice = ref(0);
// themeVars 内的值会被转换成对应 CSS 变量
// 比如 sliderBarHeight 会转换成 `--van-slider-bar-height`
const themeVars = {
  navBarBackgroundColor: "transparent",
  navBarIconColor: "#000",
};
// 提交信息
const onSubmit = () => {
  console.log(123);
};
</script>

<style scoped lang="scss">
@import "@/style/util.scss";
.settlement-wrapper {
  width: 100%;
  height: 100vh;
  background: linear-gradient($main-color 0%, #f8f6f6 40%, #f8f6f6 100%);
}
</style>
