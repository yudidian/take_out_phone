<template>
  <div class="history">
    <NavBar
      title="收藏列表"
      left-arrow
      @click-left="$router.back()"
    />
    <List
      v-model:loading="loading"
      :finished="finished"
      finished-text="没有更多了"
      @load="onLoad"
    >
      <Empty
        image="https://fastly.jsdelivr.net/npm/@vant/assets/custom-empty-image.png"
        image-size="80"
        description="空空如也~"
        v-if="storeUpList.length === 0"
      />
      <CellGroup
        v-else
        inset
        class="storeUp-wrapper"
        v-for="(item) in storeUpList"
        :key="item.id"
        @click.stop="toDetails(item,$event)"
      >
        <div class="left">
          <Image
            class="goods-image"
            fit="cover"
            :src="BASE_IMGE_URL + item.image"
          />
        </div>
        <div class="right">
          <div class="name">
            {{ item.name }}
          </div>
        </div>
      </CellGroup>
    </List>
  </div>
</template>

<script name="StoreUp" setup>
import { NavBar, List, Toast, CellGroup, Empty, Image } from 'vant'
import { ref } from 'vue'
import { sendGetStoreUpList } from '@/api/module/goods'
import { useRouter } from 'vue-router'
const router = useRouter()
const BASE_IMGE_URL = import.meta.env.VITE_LOCAL_SERVE_IMGE_URL
const storeUpList = ref([])
const loading = ref(false)
const finished = ref(false)

const onLoad = () => {
  const pageSize = 10
  const page = (storeUpList.value.length / pageSize) + 1
  getStoreUpList(page, pageSize)
}
const getStoreUpList = async (page, pageSize) => {
  const res = await sendGetStoreUpList({
    page,
    pageSize
  })
  loading.value = false
  if (res.code === 1) {
    storeUpList.value.push(...res.info.records)
    if (storeUpList.value.length >= res.info.total) {
      finished.value = true
    }
  } else {
    Toast(res.msg)
  }
}
// 跳转详情页
const toDetails = (item) => {
  router.push({
    name: 'GoodsDetail',
    params: {
      id: item.dishId ? item.dishId : item.setmealId
    },
    query: {
      title: item.name,
      type: item.type
    }
  })
}
</script>
<style scoped lang="scss">
.storeUp-wrapper {
  margin-top: 20px;
  font-size: 14px;
  color: #737373;
  display: flex;
  justify-content: flex-start;
  align-items: center;
  height: 80px;
  .left {
    .goods-image {
      width: 80px;
      height: 60px;
      border-radius: 4px;
      margin-top: 4px;
      overflow: hidden;
      margin-left: 10px;
    }
  }
  .right{
    .name{
      font-weight: 900;
      margin-left: 20px;
    }
  }
}
</style>
