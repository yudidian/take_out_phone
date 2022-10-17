<template>
  <div class="cart-bottom">
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
    <div class="Settlement">
      去结算>
    </div>
  </div>
</template>

<script setup>
defineProps({
  amount: {
    type: Number,
    default: 0
  }
})
</script>

<style scoped lang="scss">
.cart-bottom {
  width: 90%;
  height: 40px;
  margin-left: 5%;
  background-color: #5b5b5b;
  border-radius: 30px;
  position: absolute;
  bottom: 22px;
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
    margin-left: 20px;
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
