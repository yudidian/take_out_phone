<template>
  <Overlay
    :show="props.show"
    z-index="999"
  >
    <template #default>
      <div class="loading-wrapper">
        <Loading :size="30" />
      </div>
    </template>
  </Overlay>
</template>

<script setup>
import { Overlay, Loading } from 'vant'
const props = defineProps({
  show: {
    type: Boolean,
    default: () => false
  }
})
</script>

<style scoped lang="scss">
.van-overlay{
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>
