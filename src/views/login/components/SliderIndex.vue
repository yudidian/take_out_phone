<template>
  <teleport to="body">
    <div class="content">
      <div
        id="box"
        onselectstart="return false;"
      >
        <div
          class="bgColor"
          ref="bgColor"
        />
        <div
          class="txt"
          ref="txt"
        >
          滑动解锁
        </div>
        <!--给i标签添加上相应字体图标的类名即可-->
        <div
          class="slider"
          ref="icon"
        >
          <i class="iconfont icon-double-right" />
        </div>
      </div>
    </div>
  </teleport>
</template>

<script setup name="SliderIndex">
import { onMounted, ref } from 'vue'

const icon = ref(null)
const txt = ref(null)
const bgColor = ref(null)

const start = ref(0)
const txtWith = ref(0)
const moveWith = ref(0)

const emits = defineEmits(['checkFlag'])
onMounted(() => {
  txtWith.value = txt.value.clientWidth
  icon.value.addEventListener('touchstart', (e) => {
    start.value = e.targetTouches[0].pageX
  })
  icon.value.addEventListener('touchmove', (e) => {
    moveWith.value = e.targetTouches[0].pageX
    if (moveWith.value > txtWith.value) {
      icon.value.style.left = txtWith.value - icon.value.clientWidth + 'px'
      bgColor.value.style.width = txtWith.value - icon.value.clientWidth + 'px'
      bgColor.value.style.backgroundColor = 'red'
      txt.value.innerText = '验证成功'
    } else {
      icon.value.style.left = e.targetTouches[0].pageX - start.value + 'px'
      bgColor.value.style.width = e.targetTouches[0].pageX - start.value + 'px'
    }
  })
  icon.value.addEventListener('touchend', (e) => {
    if (moveWith.value < txtWith.value) {
      icon.value.style.left = 0 + 'px'
      bgColor.value.style.width = 40 + 'px'
      emits('checkFlag', false)
    } else {
      emits('checkFlag', true)
    }
  })
})
</script>

<style scoped>
* {
  padding: 0;
  margin: 0;
}
.content {
  width: 100vw;
  height: 100vh;
  position: absolute;
  top: 0;
  left: 0;
  z-index: 9999;
  background-color: rgba(73, 73, 73, 0.5);
}
#box {
  top: 50%;
  left: 50%;
  position: relative;
  width: 300px;
  height: 40px;
  margin: 10px auto 0;
  background-color: #e8e8e8;
  box-shadow: 1px 1px 5px rgba(0, 0, 0, 0.2);
  transform: translate(-62%, -50%);
}
.bgColor {
  transition: all;
  position: absolute;
  left: 0;
  top: 0;
  width: 40px;
  height: 40px;
  background-color: lightblue;
}
.txt {
  position: absolute;
  width: 100%;
  height: 40px;
  line-height: 40px;
  font-size: 14px;
  color: #000;
  text-align: center;
}
.slider {
  position: absolute;
  left: 0;
  top: 0;
  width: 50px;
  height: 38.5px;
  border: 1px solid #ccc;
  background: #fff;
  text-align: center;
  cursor: move;
}
.slider > i {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
.slider.active > i {
  color: green;
}
</style>
