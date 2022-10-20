<template>
  <div
    class="cart-bottom"
    @click="$router.push('/cart')"
  >
    <div class="logo">
      <svg
        class="icon"
        aria-hidden="true"
      >
        <use xlink:href="#icon-lahuoche" />
      </svg>
    </div>
    <div class="price">
      ￥{{ amount.toFixed(2) }}
    </div>
    <Icon name="arrow" />
  </div>
</template>

<script setup name="CartBottom">
import { Icon } from 'vant'
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
    font-size: 54px;
    .icon{
      margin-bottom: 14px;
      margin-left: 18px;
    }
  }
  .price{
    width: 100px;
    margin-left: auto;
    margin-right: 10px;
    color: red;
  }
  .Settlement {
    color: #ffffff;
    font-size: 18px;
    margin-left: auto;
    font-weight: 900;
    margin-right: 14px;
  }
}
</style>
