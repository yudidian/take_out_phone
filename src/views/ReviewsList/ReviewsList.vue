<template>
  <div class="reviews-list">
    <NavBar
      title="商品评论"
      left-arrow
      @click-left="$router.back()"
    />
    <header>
      <ul class="harder-list">
        <li
          :class="index===active? 'header-item header-active':'header-item'"
          v-for="(item,index) in headerList"
          :key="index"
          @click="chooseReviews(index,item.reta)"
        >
          {{ `${item.name}(${item.count})` }}
        </li>
      </ul>
    </header>
    <Empty
      image="https://fastly.jsdelivr.net/npm/@vant/assets/custom-empty-image.png"
      image-size="80"
      description="空空如也"
      v-if="reviewListInfo.reviewList.length === 0"
    />
    <section
      class="reviews-wrapper"
      v-else
    >
      <List
        v-model:loading="loading"
        :finished="finished"
        :immediate-check="false"
        finished-text="没有更多了"
        @load="onLoad"
      >
        <CellGroup
          inset
          class="reviews-content"
          v-for="item in reviewListInfo.reviewList"
          :key="item.id"
        >
          <div class="user-content">
            <div class="user-avatar">
              <Image
                width="100%"
                height="100%"
                :src="BASE_URL + item.avatar"
                round
                fit="cover"
                @click="viewImage([BASE_URL + item.avatar])"
              />
            </div>
            <div class="user-info">
              <p class="user-name">
                {{ item.username }}
              </p>
              <Rate
                class="user-rete"
                v-model="item.rating"
                :size="18"
                readonly
                color="#ffd21e"
                void-icon="star"
                void-color="#eee"
              />
            </div>
            <div class="reviews-times">
              {{ item.createTime }}
            </div>
          </div>
          <p class="reviews">
            {{ item.text }}
          </p>
          <div class="reviews-images">
            <Image
              class="image-item"
              width="100px"
              height="80px"
              :src="BASE_URL + imag"
              fit="cover"
              v-for="imag in item.images"
              :key="imag"
              @click="viewImage([BASE_URL + imag])"
            />
          </div>
          <div
            class="store-review"
            v-if="item.storeReview !== null"
          >
            <span class="review-left">店家回复：</span>
            <p class="review">
              {{ item.storeReview }}
            </p>
          </div>
        </CellGroup>
      </List>
    </section>
  </div>
</template>

<script setup name="ReviewsList">
import { NavBar, Image, CellGroup, Rate, Empty, ImagePreview, List } from 'vant'
import { onMounted, reactive, ref } from 'vue'
import { sendGetReviewCount, sendGetReviewList } from '@/api/module/reviews'
import { useRoute } from 'vue-router'
const BASE_URL = import.meta.env.VITE_LOCAL_SERVE_IMGE_URL
const loading = ref(false)
const finished = ref(false)
const reviewListInfo = reactive({
  total: 0,
  reviewList: [],
  currentPage: 0
})
const headerList = reactive([
  { name: '全部评论', reta: 0, count: 0 },
  { name: '好评', reta: 5, count: 0 },
  { name: '还不错', reta: 4, count: 0 },
  { name: '中等', reta: 3, count: 0 },
  { name: '一般', reta: 2, count: 0 },
  { name: '差评', reta: 1, count: 0 }
])
onMounted(() => {
  getReviewList(0)
  getReviewsCount()
})
const active = ref(0)
const route = useRoute()
const getReviewList = async (reta, page = 0, pageSize = 10) => {
  const data = {
    reta,
    page,
    pageSize
  }
  if (route.query.type === '1') {
    data.dishId = route.query.id
  } else {
    data.setmealId = route.query.id
  }
  const res = await sendGetReviewList(data)
  loading.value = false
  if (res.code === 1) {
    reviewListInfo.reviewList.push(...res.info.records)
    reviewListInfo.total = res.info.total
    reviewListInfo.currentPage = res.info.pages
    if (reviewListInfo.reviewList.length >= res.info.total) {
      finished.value = true
    }
  }
}
const onLoad = () => {
  const page = (reviewListInfo.reviewList.length / 10) + 1
  getReviewList(0, page)
}
const chooseReviews = (index, reta) => {
  active.value = index
  reviewListInfo.reviewList = []
  getReviewList(reta)
}
const getReviewsCount = async () => {
  const data = {}
  if (route.query.type === '1') {
    data.dishId = route.query.id
  } else {
    data.setmealId = route.query.id
  }
  const res = await sendGetReviewCount(data)
  if (res.code === 1) {
    const count = res.data
    headerList[0].count = count.all
    headerList[1].count = count.rate_5
    headerList[2].count = count.rate_4
    headerList[3].count = count.rate_3
    headerList[4].count = count.rate_2
    headerList[5].count = count.rate_1
  }
}
const viewImage = (images) => {
  ImagePreview({
    images, // 预览图片的那个数组
    showIndex: true,
    loop: false
  })
}
</script>

<style scoped lang="scss">
@import "@/style/util.scss";
.reviews-list{
  .harder-list{
    width: 100%;
    height: 80px;
    padding: 10px 20px 10px 10px;
    display: flex;
    justify-content: flex-start;
    flex-wrap: wrap;
    .header-item{
      width: 100px;
      height: 30px;
      border-radius: 4px;
      margin-bottom: 10px;
      font-size: 12px;
      color: #7c7c7c;
      line-height: 30px;
      margin-left: 10px;
      text-align: center;
      background-color: #ffffff;
      transition: background-color 0.3s;
      box-shadow: 2px 2px #d0d0d0, 1px 2px #b6b6b6, 2px 2px #9f9f9f;
    }
    .header-active {
      background-color: #ffc200;
      box-shadow: 2px 2px #f3ca72, 1px 2px #f3ca72;
      animation: pulse 0.3s;
    }
  }
}
.reviews-wrapper{
  width: 100%;
  height: 520px;
  overflow-y: auto;
}
.reviews-content{
  padding: 10px;
  margin-bottom: 20px;
  .user-content{
    display: flex;
    justify-content: flex-start;
    align-items: center;
    .user-avatar{
      width: 50px;
      height: 50px;
      border-radius: 60px;
      background-color: black;
    }
    .reviews-times{
      font-size: 12px;
      margin-top: 20px;
      margin-left: auto;
    }
    .user-info{
      height: 50px;
      display: flex;
      justify-content: flex-start;
      flex-direction:column;
      margin-left: 20px;
      .user-name{
        font-size: 16px;
        font-weight: 900;
        text-align: left;
      }
    }
  }
  .reviews{
    width: 300px;
    padding: 10px;
    max-height: 70px;
    font-size: 16px;
    color: #9f9f9f;
    white-space:normal;
    word-break:break-all;
    word-wrap:break-word;
    @include text-warp(3);
  }
  .reviews-images{
    height: 80px;
    margin-top: 4px;
    width: 100%;
    display: flex;
    justify-content: flex-start;
    .image-item {
      width: 100px;
      height: 80px;
      overflow: hidden;
      border-radius: 4px;
      margin-left: 4px;
    }
  }
  .store-review{
    margin-top: 10px;
    display: flex;
    align-items: center;
    .review-left{
      font-weight: 900;
      width: 60px;
      font-size: 12px;
    }
    .review{
      font-size: 14px;
    }
  }
}
</style>
