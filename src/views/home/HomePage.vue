<template>
  <header>
    <Swipe
      class="my-swipe"
      :autoplay="3000"
      indicator-color="white"
    >
      <SwipeItem>
        <img
          src="./component/image/img_3.png"
          alt=""
        >
      </SwipeItem>
      <SwipeItem>
        <img
          src="./component/image/img_2.png"
          alt=""
        >
      </SwipeItem>
      <SwipeItem>
        <img
          src="./component/image/img_1.png"
          alt=""
        >
      </SwipeItem>
      <SwipeItem>
        <img
          src="./component/image/img.png"
          alt=""
        >
      </SwipeItem>
    </Swipe>
    <div
      class="main"
    >
      <div class="go-mine">
        <img
          src="../../assets/image/user.png"
          @click="showHeader = !showHeader"
          alt="kola"
        >
      </div>
      <div :class="showHeader ? 'main-content show-main': 'main-content hid-main'">
        <div class="title">
          <div class="title-logo">
            <img
              src="@/assets/image/logo.png"
              alt="logo"
            >
          </div>
          <div class="title-name">
            <h3>koala</h3>
            <ul class="description">
              <li
                class="description-item"
                @click="getDistance"
              >
                <Icon
                  name="location-o"
                  v-if="distance === 0"
                >
                  点击获取距离
                </Icon>
                <span v-else>距离kola外卖店:{{ distance.toFixed(2) }}km</span>
              </li>
            </ul>
          </div>
        </div>
        <p class="intro">
          当前位置:{{ formattedAddress }}
        </p>
      </div>
    </div>
  </header>
  <main :class="showHeader ? 'top-40-main' : 'top-0-main'">
    <div class="type">
      <ul
        class="type-list"
        ref="listScroll"
      >
        <li
          :class="index !== defaultIndex ? 'type-item' : 'type-item active'"
          v-for="(item, index) in categoryList"
          :key="item.id"
          @click="changeCategory(item, index)"
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
          :thumb="IMG_URL + item.image"
          @click="toDetails(item,$event)"
        >
          <template #price>
            <span>￥{{ item.price / 100 }}</span>
          </template>
          <template #num>
            <Button
              type="primary"
              size="mini"
              round
              v-if="item.flavors"
              data-flag="no"
            >
              选择规格
            </Button>
            <Button
              icon="plus"
              type="primary"
              size="mini"
              data-flag="no"
              round
              v-else
            />
          </template>
        </Card>
      </ConfigProvider>
    </div>
  </main>
  <TasteSelection
    v-if="showDialog"
    title="选择规格"
    @hide="showDialog = $event"
    :dish="dish"
    :dish-type="dishType.toString()"
  />
</template>

<script setup name="HomePage">
import useMap from '@/hooks/useMap'
import { getCategory, getDish, getSetmeal } from '@/api/module/homeIndex'
import { onMounted, ref, watch } from 'vue'
import { useRouter } from 'vue-router'
import { Card, Button, ConfigProvider, Icon, Swipe, SwipeItem } from 'vant'
const router = useRouter()
const showHeader = ref(false)
const AMap = window.AMap
const IMG_URL = import.meta.env.VITE_LOCAL_SERVE_IMGE_URL
const dishList = ref([])
const dishType = ref(1)
const defaultIndex = ref(0)
const categoryList = ref([])
const dish = ref([])
const showDialog = ref(false)
const {
  getUserPosition,
  computedLine,
  distance,
  center,
  getAddress,
  formattedAddress
} = useMap(AMap)
onMounted(() => {
  sendCategory()
})
watch(center, () => {
  if (center[0] && center[1]) {
    const AMap = window.AMap
    computedLine(center[0], center[1])
    getAddress(AMap, center)
  }
})
const themeVars = {
  cardPriceColor: '#f60101',
  cardPriceFontSize: '18px'
}
const unWatch = watch(
  () => categoryList.value,
  (val) => {
    if (val && val.length > 0) {
      getDishById(val[0].id)
      unWatch()
    }
  }
)
// 跳转详情页
const toDetails = (item, e) => {
  if (e.target.nodeName === 'BUTTON') {
    showDialog.value = true
    dish.value = item
    console.log(showDialog.value, dishType.value)
    return
  }
  router.push({
    name: 'GoodsDetail',
    params: {
      id: item.id
    },
    query: {
      title: item.name,
      type: dishType.value
    }
  })
}
// 获取距离
const getDistance = () => {
  const AMap = window.AMap
  AMap &&
    AMap.plugin('AMap.Geolocation', function () {
      getUserPosition(AMap)
    })
}
// 获取菜单列表
const sendCategory = async () => {
  const res = await getCategory()
  categoryList.value = res.info
}
// 点击菜单列表处理
const changeCategory = (item, index) => {
  defaultIndex.value = index
  dishType.value = item.type
  if (item.type === 1) {
    getDishById(item.id)
  } else {
    getSetmealById(item.id)
  }
}
// 根据菜单id 获取对应菜品信息
const getDishById = async (categoryId) => {
  const res = await getDish({
    categoryId
  })
  dishList.value = res.info
}
// 根据菜单id 获取对应套餐信息
const getSetmealById = async (categoryId) => {
  const res = await getSetmeal({
    categoryId
  })
  dishList.value = res.info
}
</script>

<style scoped lang="scss">
header {
  position: relative;
  width: 100%;
  height: 152px;
  .my-swipe{
    width: 100%;
    height: 100%;
    overflow: hidden;
    border-bottom-left-radius: 14px;
    border-bottom-right-radius: 14px;
    .van-swipe-item {
      width: 100%;
      height: 152px;
      background-color: #39a9ed;
      img {
        width: 100%;
        height: 100%;
      }
    }
  }
  .go-mine {
    position: absolute;
    top: -26%;
    left: 1%;
    width: 28px;
    height: 28px;
    img {
      width: 100%;
      height: 100%;
    }
  }
  .intro {
    padding: 4px 10px;
    color: #969696;
    font-size: 12px;
  }
  .main {
    opacity: 1;
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -10%);
    width: 90%;
    height: 120px;
    border-radius: 4px;
    z-index: 999;
    .main-content{
      width: 100%;
      height: 100%;
      background-color: #ffffff;
      box-shadow: 0 1px 10px #646363;
      transition: opacity 0.8s;
    }
    .title {
      display: flex;
      padding: 10px;
      align-items: center;
      border-bottom: 1px solid #efefef;
      .title-logo {
        position: relative;
        width: 39px;
        height: 39px;
        overflow: hidden;
        border-radius: 4px;
        img {
          position: absolute;
          top: -9px;
          left: -9px;
          width: 150%;
          height: 150%;
        }
      }
      .title-name {
        display: flex;
        flex-direction: column;
        padding-left: 6px;
        h3 {
          font-size: 18px;
          font-weight: 700;
        }
        .description {
          display: flex;
          justify-content: space-between;
          font-size: 12px;
        }
      }
    }
  }
  .show-main{
    opacity: 1;
  }
  .hid-main {
    opacity: 0;
  }
}
main {
  width: 100%;
  height: calc(100vh - 240px);
  display: flex;
  margin-top: 40px;
  transition: all 0.4s;
  .type {
    width: 100px;
    background-color: #ffffff;
    display: flex;
    flex-direction: column;
    font-size: 14px;
    overflow-y: scroll;
    .type-item {
      padding: 10px 0 10px 10px;
      margin-bottom: 4px;
    }
    .active {
      border-left: 4px solid #ffc600;
    }
  }
  .dish {
    flex: calc(100vw - 100px);
    font-size: 16px;
    background-color: #f3f5f3;
    overflow-y: scroll;
  }
}
.top-0-main{
  margin-top: 8px;
  height: calc(100vh - 210px);
}
.top-40-main {
  margin-top: 30px;
  height: calc(100vh - 240px);
}
</style>
