<template>
  <teleport to="body">
    <div
      class="to-top"
      @click="$emit('click')"
    >
      <Icon name="back-top" />
    </div>
  </teleport>
</template>

<script setup name="ToTop">
import { Icon } from 'vant'
defineEmits(['click'])
</script>

<style scoped lang="scss">
.to-top{
  width: 40px;
  height: 40px;
  position: fixed;
  bottom: 40px;
  right: 20px;
  display: flex;
  font-size: 40px;
  justify-content: center;
  align-items: center;
}
</style>
