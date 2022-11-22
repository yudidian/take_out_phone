<template>
  <teleport
    to="body"
    v-if="props.show"
  >
    <div class="wrapper">
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
                v-for="(item, index) in Cpflavors[f]"
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
    </div>
  </teleport>
</template>

<script setup name="TasteSelection">
import { watch, ref } from 'vue'

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
  }
})
const Cpflavors = ref([])
const unWatch = watch(
  () => props.dish,
  (val) => {
    Cpflavors.value = val.flavors.map((item) => {
      return JSON.parse(item.value).map((v) => {
        return {
          value: v,
          active: false
        }
      })
    })
    unWatch()
  }
)
const chooseHandler = (item, j, index) => {
  Cpflavors.value[j][index].active = true
}
const addCart = () => {
  const flavorList = []
  Cpflavors.value.forEach((item) => {
    item.forEach((f) => {
      if (f.active) {
        flavorList.push(f.value)
      }
    })
  })
}
</script>

<style scoped lang="scss">
.wrapper {
  position: fixed;
  top: 0;
  z-index: 99999;
  width: 100vw;
  height: 100vh;
  display: flex;
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
}
</style>
