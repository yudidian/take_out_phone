<template>
  <transition name="fade">
    <div
      class="wrapper"
    >
      <div class="content">
        <p class="title">
          {{ props.title }}
        </p>
        <div class="flavors">
          <div
            class="flavors-name"
            v-for="(flavor, f) in props.dish.flavors"
            :key="flavor.id"
          >
            <p class="name">
              {{ flavor.name }}
            </p>
            <ul class="flavors-content">
              <li
                :class="item.active ? 'flavors-item active' : 'flavors-item'"
                v-for="(item, index) in CpFlavors[f]"
                :key="item.value"
                @click="chooseHandler(item, f, index)"
              >
                {{ item.value }}
              </li>
            </ul>
          </div>
        </div>
        <footer>
          <span class="price"> ￥{{ props.dish.price / 100 }} </span>
          <button
            class="btn"
            @click="addCart"
          >
            加入购物车
          </button>
        </footer>
      </div>
      <div
        class="cancel"
        @click="$emit('hide', false)"
      >
        <Icon
          name="close"
          size="40"
        />
      </div>
    </div>
  </transition>
</template>

<script setup name="TasteSelection">
import { watch, ref } from 'vue'
import { sendAddCart } from '@/api/module/goods.js'
import { Icon, Toast } from 'vant'
const emit = defineEmits(['hide', 'changeHandler'])
watch(
  () => props.show,
  (value) => {
    show.value = value
  }
)
const props = defineProps({
  title: {
    type: String,
    default: () => '自定义标题'
  },
  show: {
    type: Boolean,
    default: () => false
  },
  dish: {
    type: Object,
    default: () => {}
  },
  dishType: {
    type: String,
    default: '1'
  }
})
const CpFlavors = ref([])
const show = ref(false)
watch(
  () => props.dish,
  (val) => {
    CpFlavors.value = val.flavors.map((item) => {
      return JSON.parse(item.value).map((v) => {
        return {
          value: v,
          active: false
        }
      })
    })
  }, { immediate: true }
)
const chooseHandler = (item, j, index) => {
  CpFlavors.value[j][index].active = true
}
const addCart = async () => {
  const flavorList = []
  CpFlavors.value.forEach((item) => {
    item.forEach((f) => {
      if (f.active) {
        flavorList.push(f.value)
      }
    })
  })
  const data = {
    name: props.dish.name,
    dishFlavor: flavorList.toString(),
    number: 1,
    amount: props.dish.price,
    image: props.dish.image
  }
  if (props.dishType === '1') {
    data.dishId = props.dish.id
  } else {
    data.setmealId = props.dish.id
  }
  const res = await sendAddCart(data)
  show.value = false
  if (res.code === 1) {
    Toast.success('添加成功')
    emit('changeHandler')
    emit('hide')
  } else {
    Toast.fail('添加失败')
  }
}
</script>

<style scoped lang="scss">
/* 进入之前和离开后的样式 */
.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
/* 离开和进入过程中的样式 */
.fade-enter-active,
.fade-leave-active {
  /* 添加过渡动画 */
  transition: opacity 0.5s ease;
}
/* 进入之后和离开之前的样式 */
.fade-enter-to,
.fade-leave-from {
  opacity: 1;
}
.wrapper {
  position: fixed;
  top: 0;
  z-index: 99999;
  width: 100vw;
  height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background-color: rgba(124, 122, 122, 0.5);
  .content {
    position: relative;
    width: 90vw;
    min-height: 200px;
    background-color: #ffffff;
    border-radius: 4px;
    box-shadow: 0 1px 8px #7e7d7d;
    .title {
      padding: 5px 0;
      font-weight: 900;
      font-size: 18px;
      text-align: center;
    }
    .flavors {
      font-size: 14px;
      .flavors-name {
        display: flex;
        flex-direction: column;
        .name {
          text-indent: 2em;
          margin-bottom: 4px;
        }
        .flavors-content {
          display: flex;
          padding-left: 2em;
          margin-bottom: 4px;
          .flavors-item {
            width: 60px;
            height: 25px;
            background-color: #ffffff;
            border: 1px solid #ffb200;
            margin-right: 10px;
            border-radius: 4px;
            text-align: center;
            line-height: 25px;
            font-weight: 700;
          }
          .active {
            background-color: #ffb200;
          }
        }
      }
    }
    footer {
      position: relative;
      bottom: 10px;
      display: flex;
      align-items: center;
      justify-content: flex-start;
      margin-top: 20px;
      .price {
        width: 30px;
        height: 30px;
        padding: 0 10px;
        color: #f52d2d;
        font-size: 16px;
        font-weight: 900;
      }
      .btn {
        width: 120px;
        height: 30px;
        border-radius: 15px;
        line-height: 30px;
        border: none;
        font-size: 14px;
        margin-left: 160px;
        background-color: #ffb200;
      }
    }
  }
  .cancel {
    margin-top: 20px;
    color: #3a3a3a;
  }
}
</style>
