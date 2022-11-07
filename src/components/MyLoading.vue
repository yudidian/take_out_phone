<template>
  <Overlay
    :show="props.show"
    z-index="99999999"
  >
    <template #default>
      <div class="loader" />
    </template>
  </Overlay>
</template>

<script setup name="MyLogin">
import { Overlay } from 'vant'
const props = defineProps({
  show: {
    type: Boolean,
    default: () => false
  }
})
</script>

<style scoped>
.loader {
  width: 48px;
  height: 48px;
  margin: auto;
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
}

.loader:before {
  content: '';
  width: 48px;
  height: 5px;
  background: #f0808050;
  position: absolute;
  top: 60px;
  left: 0;
  border-radius: 50%;
  animation: shadow324 0.5s linear infinite;
}

.loader:after {
  content: '';
  width: 100%;
  height: 100%;
  background: #ffc200;
  position: absolute;
  top: 0;
  left: 0;
  border-radius: 4px;
  animation: jump7456 0.5s linear infinite;
}

@keyframes jump7456 {
  15% {
    border-bottom-right-radius: 3px;
  }

  25% {
    transform: translateY(9px) rotate(22.5deg);
  }

  50% {
    transform: translateY(18px) scale(1, .9) rotate(45deg);
    border-bottom-right-radius: 40px;
  }

  75% {
    transform: translateY(9px) rotate(67.5deg);
  }

  100% {
    transform: translateY(0) rotate(90deg);
  }
}

@keyframes shadow324 {

  0%,
  100% {
    transform: scale(1, 1);
  }

  50% {
    transform: scale(1.2, 1);
  }
}
</style>
