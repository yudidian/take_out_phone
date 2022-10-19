<template>
  <div class="cart-wrapper">
    <CellGroup inset>
      <Cell
        style="background-color: #ffffff"
        v-for="(item, index) in cartInfoList"
        :key="item.id"
      >
        <Card
          class="cart-item"
          :price="(item.amount / 100).toFixed(2)"
          :title="item.name"
          :thumb="IMG_URL+item.image"
        >
          <template #footer>
            <Button
              round
              size="mini"
              icon="minus"
              @click="addOrLessHandler(item,'less',index)"
            />
            <span class="cart-number">{{ item.number }}</span>
            <Button
              round
              size="mini"
              icon="plus"
              @click="addOrLessHandler(item,'add',index)"
            />
          </template>
        </Card>
      </Cell>
    </CellGroup>
  </div>
</template>

<script setup>
import { Button, Card, Cell, CellGroup, Dialog, Notify } from 'vant'
import { sendAddCart, sendDeleteCartOne, sendGetCartList, sendLessCartCount } from '@/api/module/goods.js'
import { computed, onMounted, ref } from 'vue'

const emits = defineEmits(['getPrice'])
const IMG_URL = import.meta.env.VITE_LOCAL_SERVE_IMGE_URL
// 购物车列表
const cartInfoList = ref([])
onMounted(() => {
  getCartList()
})
const price = computed(() => {
  return cartInfoList.value.reduce((pre, item) => {
    return pre + item.number * item.amount
  }, 0)
})
// 商品数量加减
const addOrLessHandler = async (item, flag, index) => {
  if (item.number >= 99) {
    Notify({
      type: 'danger',
      message: '商品可添加数量最大为99'
    })
    return
  }
  // 减操作
  if (flag === 'less') {
    if (item.number > 1) {
      const res = await sendLessCartCount(item)
      if (res.code === 1) {
        cartInfoList.value[index] = res.info
      } else {
        Notify({
          type: 'danger',
          message: res.msg
        })
      }
    } else {
      Dialog.confirm({
        title: '标题',
        message: '是否删除改商品'
      }).then(async () => {
        const res = await sendDeleteCartOne(item)
        if (res.code === 1) {
          cartInfoList.value.splice(index, 1)
        } else {
          Notify({
            type: 'danger',
            message: res.msg
          })
        }
      })
    }
    emits('getPrice', price)
  } else {
    // 加操作
    const res = await sendAddCart(item)
    if (res.code === 1) {
      cartInfoList.value[index] = res.info
      emits('getPrice', price)
    } else {
      Notify({
        type: 'danger',
        message: res.msg
      })
    }
  }
}

// 获取购物车列表
const getCartList = async () => {
  const res = await sendGetCartList()
  if (res.code === 1) {
    cartInfoList.value = res.info
    emits('getPrice', price.value)
  } else {
    Notify({
      type: 'danger',
      message: res.msg
    })
  }
}
</script>

<style scoped lang="scss">
.cart-wrapper {
  overflow-y: auto;
  height: calc(100vh - 50px);
  .cart-item {
    position: relative;
    height: 88px;
    margin-top: 10px;
    background-color: #ffffff;
    :deep(.van-card__title){
      margin-top: 10px;
    }
    :deep(.van-card__thumb){
      width: 80px;
      height: 80px;
    }
    :deep(.van-card__bottom){
      margin-bottom: 4px;
    }
    :deep(.van-card__footer) {
      position: absolute;
      bottom: -4px;
      height: 24px;
      left: 70%;
      display: flex;
      justify-content: flex-end;
      align-items: center;
      .cart-number {
        height: 24px;
        font-size: 14px;
        width: 20px;
        color: red;
        text-align: center;
        line-height: 24px;
        margin-left: 4px;
      }
    }
  }
}
</style>
