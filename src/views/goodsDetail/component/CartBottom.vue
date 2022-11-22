<template>
  <SubmitBar
    :price="amount * 100"
    button-text="去购物车"
    @submit="$router.push('/cart')"
  />
</template>

<script setup name="CartBottom">
import { SubmitBar } from 'vant'
defineProps({
  amount: {
    type: Number,
    default: 0
  }
})
</script>

<style scoped lang="scss">
.cart-bottom {
  width: 100%;
  height: 48px;
  background-color: #ffffff;
  position: absolute;
  bottom: 0;
  display: flex;
  align-items: center;
  justify-content: flex-start;
  .logo {
    width: 54px;
    height: 54px;
    font-size: 38px;
    .icon {
      margin-bottom: 3px;
    }
  }
  .price {
    width: 100px;
    margin-left: auto;
    color: red;
  }
}
</style>
