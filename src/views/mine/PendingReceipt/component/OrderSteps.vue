<template>
  <Steps
    :active="(state - 1)"
    active-color="#ffc200"
  >
    <Step>买家下单</Step>
    <Step>商家接单</Step>
    <Step>商家已发货</Step>
    <Step>交易完成</Step>
  </Steps>
</template>

<script setup name="OrderSteps">
import { Steps, Step } from 'vant'
defineProps({
  state: {
    type: Number,
    default: 1
  }
})
</script>

<style scoped>

</style>
