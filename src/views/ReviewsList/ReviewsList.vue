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
          @click="active = index"
        >
          {{ item }}(999)
        </li>
      </ul>
    </header>
    <section class="reviews-content">
      <div class="user-content">
        <div class="user-avatar">
          <Image
            src="xxx"
            fit="cover"
          />
        </div>
        <div class="user-name">
          123132
        </div>
      </div>
      <div class="reviews">
        11231232323231231
      </div>
      <div class="reviews-images">
        <Image
          src=""
          fit="cover"
        />
        <Image
          src=""
          fit="cover"
        />
        <Image
          src=""
          fit="cover"
        />
      </div>
    </section>
  </div>
</template>

<script setup name="ReviewsList">
import { NavBar, Image } from 'vant'
import { ref } from 'vue'
defineProps({
  id: {
    type: String,
    required: true
  }
})
const headerList = [
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
    padding: 10px;
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

    }
  }
  .reviews{
    @include text-warp(3)
  }
  .reviews-images{
    display: flex;
    justify-content: flex-start;
  }
}
</style>
