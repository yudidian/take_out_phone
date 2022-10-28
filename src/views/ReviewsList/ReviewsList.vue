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
          v-for="(item,index) in HEADER_LIST"
          :key="index"
          @click="active = index"
        >
          {{ item }}(999)
        </li>
      </ul>
    </header>
    <CellGroup
      inset
      class="reviews-content"
    >
      <div class="user-content">
        <div class="user-avatar">
          <Image
            width="100%"
            height="100%"
            src="https://fastly.jsdelivr.net/npm/@vant/assets/cat.jpeg"
            round
            fit="cover"
          />
        </div>
        <div class="user-info">
          <p class="user-name">
            12300
          </p>
          <Rate
            class="user-rete"
            v-model="rate"
            :size="18"
            readonly
            color="#ffd21e"
            void-icon="star"
            void-color="#eee"
          />
        </div>
        <div class="reviews-times">
          2020-10-28 10:10:10
        </div>
      </div>
      <p class="reviews">
        112312323232312311111111111111112222qqqqxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
      </p>
      <div class="reviews-images">
        <Image
          class="image-item"
          width="100%"
          height="100%"
          src="https://fastly.jsdelivr.net/npm/@vant/assets/cat.jpeg"
          fit="cover"
        />
        <Image
          class="image-item"
          width="100%"
          height="100%"
          src="https://fastly.jsdelivr.net/npm/@vant/assets/cat.jpeg"
          fit="cover"
        />
        <Image
          class="image-item"
          width="100%"
          height="100%"
          src="https://fastly.jsdelivr.net/npm/@vant/assets/cat.jpeg"
          fit="cover"
        />
      </div>
    </CellGroup>
  </div>
</template>

<script setup name="ReviewsList">
import { NavBar, Image, CellGroup, Rate } from 'vant'
import { ref } from 'vue'
defineProps({
  id: {
    type: String,
    required: true
  }
})
const rate = ref(1)
const HEADER_LIST = [
  '全部评论', '最新', '好评', '一般', '差评'
]
const active = ref(0)
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
      margin-bottom: 10px;
      font-size: 12px;
      color: #7c7c7c;
      line-height: 30px;
      margin-left: 10px;
      text-align: center;
      background-color: #ffffff;
      transition: background-color 0.3s;
      box-shadow: 2px 2px #d0d0d0, 1px 2px #b6b6b6;
    }
    .header-active {
      background-color: #ffc200;
      box-shadow: 2px 2px #f3ca72, 1px 2px #f3ca72;
      animation: pulse 0.3s;
    }
  }
}
.reviews-content{
  padding: 10px;
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
}
</style>
