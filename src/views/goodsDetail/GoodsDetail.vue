<template>
  <div class="goods-detail">
    <div class="nav">
      <span
        class="iconfont icon-back nav-left"
        @click="$router.back()"
      />
    </div>
    <img
      class="goods-image"
      :src="IMG_URL+goodsInfo.image"
      alt="info"
    >
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
            {{ isFavorites ? "取消收藏":"收藏" }}
          </div>
        </div>
        <div class="price">
          <div class="price-left">
            <div class="left-info">
              <div class="sort">
                月销售量 {{ goodsInfo.sort }}
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
              round
              v-else
            />
          </div>
        </div>
        <TabNav />
      </div>
    </CellGroup>
  </div>
  <TasteSelection
    title="选择规格"
    @hide="showDialog = $event"
    :dish="goodsInfo"
    :show="showDialog"
  />
</template>

<script setup>
import { Notify, Button, CellGroup } from 'vant'
import { onMounted, ref } from 'vue'
import { useRoute } from 'vue-router'
import { useStore } from 'vuex'
import TabNav from './component/TabNav.vue'
import { sendGoodsInfo, sendChangeFavorites, sendGetFavorites } from '@/api/module/goods'
const IMG_URL = import.meta.env.VITE_LOCAL_SERVE_IMGE_URL
const store = useStore()
const route = useRoute()
// 商品信息
const goodsInfo = ref({})
// 是否收藏
const isFavorites = ref(false)
// 是否显示口味列表
const showDialog = ref(false)
onMounted(async () => {
  const res = await Promise.allSettled([sendGoodsInfo(route.params.id), sendGetFavorites(route.params.id)])
  setGoodsInfo(res)
})
// 处理商品信息
const setGoodsInfo = (res) => {
  const first = res[0].value
  const last = res[1].value
  if (first.code === 1 && last.code === 1) {
    goodsInfo.value = first.info
    isFavorites.value = last.data.isFavorites
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
    dishId: route.params.id,
    userId: store.getters.userId
  })
  if (res.code === 1) {
    isFavorites.value = !isFavorites.value
    Notify({
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
</script>

<style scoped lang="scss">
.goods-detail{
  .nav{
    position: fixed;
    top: 0;
    width: 100%;
    height: 40px;
    background-color: rgba(131, 126, 126, 0.1);
    .nav-left{
      font-size: 20px;
      margin-left: 10px;
    }
  }
  .goods-image{
    width: 100%;
    height: 220px;
  }
  .content{
    padding: 10px;
    .header{
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
      .left{
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
      .price-left{
        width: 80%;
        .left-info{
          display: flex;
          flex-direction: column;
          justify-content: flex-start;
          align-items: flex-start;
          width: 120px;
          .sort{
            color: #9f9f9f;
            font-size: 18px;
            transform: scale(0.5);
            margin-left: -10px;
          }
          .number{
            font-size: 18px;
            color: #f33131;
          }
        }
      }
      .price-right{
        height: 100%;
      }
    }
  }
}
</style>
