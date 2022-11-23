<template>
  <CellGroup inset>
    <div class="content">
      <ul class="header-tab">
        <li
          v-for="(item, index) in headerTab"
          :key="index"
          :class="active === index ? 'tab active' : 'tab'"
          @click="changeActive(item, index)"
        >
          {{ item }}
        </li>
      </ul>
      <ul class="description-wrapper">
        <li class="wrapper-item">
          <span class="left">掌柜描述</span>
          <p class="right">
            {{ descriptionInfo.description ? descriptionInfo.description : '暂无' }}
          </p>
        </li>
        <li class="wrapper-item">
          <span class="left">主料</span>
          <p class="right">
            {{ descriptionInfo.mainMeterial ? descriptionInfo.mainMeterial : '暂无' }}
          </p>
        </li>
        <li class="wrapper-item">
          <span class="left">制作方式</span>
          <p class="right">
            {{ descriptionInfo.productionMethod ? descriptionInfo.productionMethod : '暂无' }}
          </p>
        </li>
        <li class="wrapper-item">
          <span class="left">数量</span>
          <p class="right">
            {{ descriptionInfo.count ? descriptionInfo.count : '暂无' }}
          </p>
        </li>
        <li class="wrapper-item">
          <span class="left">口味</span>
          <p class="right">
            {{ descriptionInfo.taste ? descriptionInfo.taste : '暂无' }}
          </p>
        </li>
      </ul>
    </div>
  </CellGroup>
</template>

<script setup name="TabNav">
import { CellGroup } from 'vant'
import { ref } from 'vue'
import { useRouter } from 'vue-router'
const props = defineProps({
  descriptionInfo: {
    type: Object,
    required: true
  },
  id: {
    type: String,
    default: ''
  },
  type: {
    // 区别普通菜品和套餐
    type: String,
    required: false,
    default: ''
  }
})
const router = useRouter()
const active = ref(0)
const headerTab = ['详情', '评价']
const changeActive = (item, index) => {
  active.value = index
  if (index === 1) {
    router.push({
      name: 'ReviewsList',
      query: {
        id: props.id,
        type: props.type
      }
    })
  }
}
</script>

<style scoped lang="scss">
@import "../../../style/util.scss";
.content {
  .header-tab {
    display: flex;
    justify-content: flex-start;
    font-size: 14px;
    padding-top: 6px;
    .tab {
      width: auto;
      margin-right: 20px;
      border-bottom: 4px solid #ffffff;
      transition: border-bottom-color 0.5s;
    }
    .active {
      border-bottom: 4px solid #ffc200;
    }
  }
  .description-wrapper {
    width: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    .wrapper-item {
      display: flex;
      height: 40px;
      align-items: center;
      justify-content: space-between;
      .left {
        width: 70px;
        font-size: 12px;
        color: #9f9f9f;
      }
      .right {
        font-size: 12px;
        width: 240px;
        word-break: break-word;
        @include text-warp(2);
      }
    }
  }
}
</style>
