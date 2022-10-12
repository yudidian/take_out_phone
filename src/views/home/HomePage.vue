<template>
  <header>
    <div class="main">
      <div class="go-mine">
        <img
          src="../../assets/image/user.png"
          @click="$router.push('/mine')"
          alt="kola"
        >
      </div>
      <div class="title">
        <div class="title-logo">
          <img
            src="@/assets/image/logo.png"
            alt="logo"
          >
        </div>
        <div class="title-name">
          <h3>kola</h3>
          <ul class="description">
            <li class="description-item">
              距离1.5k
            </li>
            <li class="description-item">
              距离1.5k
            </li>
            <li class="description-item">
              距离1.5k
            </li>
          </ul>
        </div>
      </div>
      <p class="intro">
        xxxxxxxxxxxxxxxx
      </p>
    </div>
  </header>
  <main>
    <div class="type">
      <ul class="type-list">
        <li
          :class="index !== defaultIndex ? 'type-item' : 'type-item active'"
          v-for="(item,index) in categoryList"
          :key="item.id"
          @click="changeCategory(item,index)"
        >
          {{ item.name }}
        </li>
      </ul>
    </div>
    <div class="dish">
      <ConfigProvider :theme-vars="themeVars">
        <Card
          v-for="item in dishList"
          :key="item.id"
          :desc="item.description"
          :title="item.name"
          :thumb="IMG_URL+item.image"
          @click="toDetails(item)"
        >
          <template #price>
            <span>￥{{ (item.price / 100) }}</span>
          </template>
          <template #num>
            <Button
              type="primary"
              size="mini"
              round
              v-if="item.flavors"
              @click="chooseFlavors(item)"
            >
              选择规格
            </Button>
            <Button
              size="mini"
              round
              v-else
            >
              加入购物车
            </Button>
          </template>
        </Card>
      </ConfigProvider>
    </div>
  </main>
  <MyLoading :show="isLoading" />
  <TasteSelection
    :dish="dish"
    :show="showDialog"
  />
</template>

<script setup>
import TasteSelection from './component/TasteSelection.vue'
import { getCategory, getDish } from '@/api/module/homeIndex'
import { onMounted, ref, watch } from 'vue'
import { Card, Button, ConfigProvider } from 'vant'
const IMG_URL = import.meta.env.VITE_LOCAL_SERVE_IMGE_URL
const dishList = ref([])
const defaultIndex = ref(0)
const categoryList = ref([])
const isLoading = ref(false)
const dish = ref([])
const showDialog = ref(false)
onMounted(() => {
  sendCategory()
})
const themeVars = {
  cardPriceColor: '#f60101',
  cardPriceFontSize: '18px'
}
const unWatch = watch(() => categoryList.value, (val) => {
  getDishById(val[0].id)
  unWatch()
})
// 跳转详情页
const toDetails = (item) => {
  console.log(item)
}

// 获取菜单列表
const sendCategory = async () => {
  const res = await getCategory()
  categoryList.value = res.info
}
// 点击菜单列表处理
const changeCategory = (item, index) => {
  defaultIndex.value = index
  if (item.type === 1) {
    getDishById(item.id)
  } else {
    console.log(123)
  }
}
// 根据菜单id 获取对应菜品信息
const getDishById = async (categoryId) => {
  isLoading.value = true
  const res = await getDish({
    categoryId
  })
  dishList.value = res.info
  isLoading.value = false
}
const chooseFlavors = (val) => {
  showDialog.value = true
  dish.value = val
}
</script>

<style scoped lang="scss">
header{
  position: relative;
  width: 100%;
  height: 152px;
  background-image: url("../../assets/image/mainBg.png");
  background-repeat: no-repeat;
  background-size: contain;
  .go-mine{
    position: absolute;
    top: -26%;
    left: 1%;
    width: 28px;
    height: 28px;
    img{
      width: 100%;
      height: 100%;
    }
  }
  .intro{
    padding: 4px 10px;
    color: #969696;
    font-size: 14px;
  }
  .main{
    position: absolute;
    left: 50%;
    top: 50%;
    transform:translate(-50%,-10%);
    width: 90%;
    height: 120px;
    background-color: #FFFFFF;
    border-radius: 4px;
    box-shadow: 0 1px 10px #646363;
    .title{
      display: flex;
      padding: 10px;
      align-items: center;
      border-bottom: 1px solid #efefef;
      .title-logo{
        position: relative;
        width: 39px;
        height: 39px;
        overflow: hidden;
        border-radius: 4px;
        img{
          position: absolute;
          top: -9px;
          left: -9px;
          width: 150%;
          height: 150%;
        }
      }
      .title-name{
        flex: auto;
        display: flex;
        flex-direction: column;
        padding-left: 6px;
        h3{
          font-size: 18px;
          font-weight: 700;
        }
        .description{
          display: flex;
          justify-content: space-between;
          font-size: 12px;
        }
      }
    }
  }
}
main{
  width: 100%;
  height: calc(100vh - 240px);
  display: flex;
  margin-top: 40px;
  .type{
    width: 100px;
    background-color: #ffffff;
    display: flex;
    flex-direction: column;
    font-size: 14px;
    overflow-y: scroll;
    .type-item{
      padding: 10px 0 10px 10px;
      margin-bottom: 4px;
    }
    .active{
      border-left: 4px solid #FFC600;
    }
  }
  .dish{
    flex: calc(100vw - 100px);
    font-size: 16px;
    background-color: #f3f5f3;
    overflow-y: scroll;
  }
}
</style>
