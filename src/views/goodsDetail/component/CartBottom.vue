<template>
  <div
    class="cart-bottom"
    @click="$router.push('/cart')"
  >
    <div class="price">
      ￥{{ amount.toFixed(2) }}
    </div>
    <div class="logo">
      <svg
        class="icon"
        aria-hidden="true"
      >
        <use xlink:href="#icon-lahuoche" />
      </svg>
    </div>
  </div>
</template>

<script setup name="CartBottom">
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
