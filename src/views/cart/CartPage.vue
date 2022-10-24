<template>
  <div class="cart-content">
    <NavBar left-arrow title="我的购物车" @click-left="$router.back()" />
    <CartList @get-price="getPrice" />
    <SubmitBar
      :price="price"
      button-text="去结算"
      @submit="$router.push('/settlement')"
    />
  </div>
</template>

<script setup name="CartPage">
import { SubmitBar, NavBar } from "vant";
import { ref } from "vue";
const price = ref(0);
const getPrice = (val) => {
  price.value = val;
};
</script>

<style lang="scss" scoped></style>
