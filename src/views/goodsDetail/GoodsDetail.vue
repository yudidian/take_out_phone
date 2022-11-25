<template>
  <div class="goods-detail">
    <div class="nav">
      <span
        class="iconfont icon-back nav-left"
        @click="$router.back()"
      />
    </div>
    <Image
      class="goods-image"
      :src="goodsInfo.image !== undefined ? IMG_URL + goodsInfo.image : ''"
      @click="ImagePreview([IMG_URL + goodsInfo.image])"
    />
    <CellGroup>
      <div class="content">
        <div class="header">
          <p class="title-name .txt-cut">
            {{ goodsInfo.name }}
          </p>
          <div
            class="left"
            @click="changeFavorites"
          >
            <svg
              class="icon"
              aria-hidden="true"
              v-if="isFavorites"
            >
              <use xlink:href="#icon-shoucang" />
            </svg>
            <svg
              class="icon"
              aria-hidden="true"
              v-else
            >
              <use xlink:href="#icon-shoucang1" />
            </svg>
            {{ isFavorites ? "取消收藏" : "收藏" }}
          </div>
        </div>
        <div class="price">
          <div class="price-left">
            <div class="left-info">
              <div class="sort">
                月销售量 {{ goodsInfo.salesVolume }}
              </div>
              <div class="number">
                ￥{{ (goodsInfo.price / 100).toFixed(2) }}
              </div>
            </div>
          </div>
          <div class="price-right">
            <Button
              type="primary"
              size="mini"
              round
              v-if="goodsInfo.flavors"
              @click="chooseFlavors()"
            >
              选择规格
            </Button>
            <Button
              icon="plus"
              type="primary"
              size="mini"
              @click="addCart"
              round
              v-else
            />
          </div>
        </div>
        <TabNav
          :description-info="descriptionInfo"
          :id="goodsInfo.id"
          :type="$route.query.type"
        />
      </div>
    </CellGroup>
    <CartBottom :amount="cartInfo.amount" />
    <TasteSelection
      v-if="showDialog"
      title="选择规格"
      @hide="showDialog = $event"
      :dish="goodsInfo"
      :dish-type="$route.query.type"
      @change-handler="getCartList"
    />
  </div>
</template>

<script setup name="GoodsDetail">
import { Button, CellGroup, Notify, Toast, Image, ImagePreview } from 'vant'
import { onMounted, ref, watch } from 'vue'
import { useRoute } from 'vue-router'
import TabNav from './component/TabNav.vue'
import CartBottom from './component/CartBottom.vue'
import {
  sendChangeFavorites,
  sendGetFavorites,
  sendGoodsInfo,
  sendGetDishDescription, sendSetmealInfo, sendAddCart
} from '@/api/module/goods'
import { useCart } from '@/hooks/useCart'
const IMG_URL = import.meta.env.VITE_LOCAL_SERVE_IMGE_URL
const route = useRoute()
const { cartInfo, getCartList } = useCart()
// 商品描述信息
const descriptionInfo = ref({})
// 商品信息
const goodsInfo = ref({})
// 是否收藏
const isFavorites = ref(false)
// 是否显示口味列表
const showDialog = ref(false)
// 购物车列表数据
onMounted(async () => {
  let getGoodsInfo = null
  if (route.query.type === '1') {
    getGoodsInfo = sendGoodsInfo(route.params.id)
  } else {
    getGoodsInfo = sendSetmealInfo(route.params.id)
  }
  const res = await Promise.allSettled([
    getGoodsInfo,
    sendGetFavorites(route.params.id, route.query.type),
    getCartList(),
    sendGetDishDescription(route.params.id)
  ])
  setGoodsInfo(res)
})
// 监听cartList 改变
watch(
  () => cartInfo.cartList,
  (value) => {
    // console.log(value)
  }
)
// 处理商品信息
const setGoodsInfo = (res) => {
  const goods = res[0].value
  const description = res[3].value
  const favorites = res[1].value
  if (goods.code === 1 && favorites.code === 1 && description.code === 1) {
    goodsInfo.value = goods.info
    descriptionInfo.value = description.info
    isFavorites.value = favorites.data.isFavorites
  } else {
    Notify({
      type: 'danger',
      message: '获取数据失败'
    })
  }
}
// 选择规格
const chooseFlavors = () => {
  showDialog.value = true
}
// 取消或收藏
const changeFavorites = async () => {
  const res = await sendChangeFavorites({
    id: route.params.id,
    type: route.query.type
  })
  if (res.code === 1) {
    isFavorites.value = !isFavorites.value
    Toast({
      type: 'success',
      message: '操作成功'
    })
  } else {
    Notify({
      type: 'danger',
      message: '操作失败'
    })
  }
}
const addCart = async () => {
  const data = {
    name: goodsInfo.value.name,
    number: 1,
    setmealId: goodsInfo.value.id,
    amount: goodsInfo.value.price,
    image: goodsInfo.value.image
  }
  const res = await sendAddCart(data)
  if (res.code === 1) {
    await getCartList()
    Toast.success('添加成功')
  } else {
    Toast.fail('添加失败')
  }
}
</script>

<style scoped lang="scss">
.goods-detail {
  .nav {
    position: fixed;
    top: 0;
    width: 100%;
    height: 40px;
    z-index: 99;
    background-color: rgba(122, 122 ,122, 0.1);
    .nav-left {
      font-size: 20px;
      margin-left: 10px;
    }
  }
  .goods-image {
    width: 100%;
    height: 220px;
  }
  .content {
    padding: 10px;
    .header {
      width: 100%;
      height: 50px;
      display: flex;
      align-items: center;
      justify-content: flex-start;
      .title-name {
        width: 90%;
        font-size: 20px;
        font-weight: 700;
      }
      .left {
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        align-items: center;
        width: 50px;
        height: 100%;
        color: #969696;
        font-size: 12px;
        svg {
          height: 32px;
          font-size: 30px;
        }
      }
    }
    .price {
      display: flex;
      align-items: center;
      justify-content: flex-start;
      width: 100%;
      height: 50px;
      padding-bottom: 20px;
      border-bottom: 2px solid #e7e7e7;
      .price-left {
        width: 80%;
        .left-info {
          display: flex;
          flex-direction: column;
          justify-content: flex-start;
          align-items: flex-start;
          width: 120px;
          .sort {
            color: #9f9f9f;
            font-size: 18px;
            transform: scale(0.6);
            margin-left: -10px;
          }
          .number {
            font-size: 18px;
            color: #f33131;
            font-weight: 900;
          }
        }
      }
      .price-right {
        height: 100%;
      }
    }
  }
}
</style>
