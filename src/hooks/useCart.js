import { reactive, watch } from 'vue'
import { sendGetCartList } from '@/api/module/goods.js'
import { Notify } from 'vant'
import { useStore } from 'vuex'
export const useCart = () => {
  const store = useStore()
  const cartInfo = reactive({
    cartList: [],
    amount: 0
  })
  // 监听cartList 改变
  watch(
    () => cartInfo.cartList,
    () => {
      cartInfo.amount = cartInfo.cartList.reduce((pre, item) => {
        return pre + (item.number * item.amount) / 100
      }, 0)
    },
    {
      deep: true
    }
  )
  // 获取购物车数据
  const getCartList = async () => {
    if (store.getters.token === '') {
      cartInfo.cartList = []
      return
    }
    const res = await sendGetCartList()
    if (res.code === 1) {
      cartInfo.cartList = res.info
    } else {
      Notify({
        type: 'danger',
        message: '获取数据失败'
      })
    }
  }
  return {
    getCartList,
    cartInfo
  }
}
