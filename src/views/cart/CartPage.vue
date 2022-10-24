<template>
  <div class="cart-content">
    <NavBar
      left-arrow
      title="我的购物车"
      @click-left="$router.back()"
    />
    <CartList
      ref="cartList"
      @get-cart-length="getCartLength"
      @get-price="getPrice"
    />
    <SubmitBar
      :disabled="disabled"
      :price="price"
      button-text="去结算"
      @submit="$router.push('/settlement')"
    />
  </div>
</template>

<script setup name="CartPage">
import { SubmitBar, NavBar } from 'vant'
import { ref } from 'vue'
const disabled = ref(false)
const cartList = ref(null)
const price = ref(0)
const getPrice = (val) => {
  price.value = val
}
const getCartLength = (val) => {
  disabled.value = !(val > 0)
}
</script>

<style lang="scss" scoped></style>
