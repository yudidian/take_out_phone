<template>
  <div class="write_review">
    <NavBar
      title="写商品评论"
      left-arrow
      @click-left="$router.back()"
    />
    <Form @submit="onSubmit">
      <CellGroup inset>
        <div class="goods">
          <div class="goods-info">
            <img :src="BASE_URL + $route.query.image">
            <span class="name">{{ $route.query.name }}</span>
          </div>
          <Field
            name="rate"
            label="评分"
          >
            <template #input>
              <Rate
                color="#ffd21e"
                void-icon="star"
                void-color="#eee"
                v-model="reviews.rate"
              />
            </template>
          </Field>
          <Field
            v-model="text"
            rows="2"
            autosize
            name="评论"
            label="评论"
            type="textarea"
            maxlength="250"
            placeholder="请输入评论"
            show-word-limit
          />
        </div>
        <Field
          name="uploader"
          label="图片"
        >
          <template #input>
            <Uploader
              v-model="fileList"
              multiple
              :before-read="beforeRead"
              :after-read="afterRead"
              :max-count="3"
            />
          </template>
        </Field>
      </CellGroup>
      <div style="margin: 16px;">
        <Button
          round
          block
          type="primary"
          native-type="submit"
        >
          提交
        </Button>
      </div>
    </Form>
  </div>
</template>

<script setup name="WriteReview">
import { NavBar, Toast, Button, Form, Field, CellGroup, Uploader, Rate } from 'vant'
import { reactive, ref } from 'vue'
import { sendUploadImage } from '@/api/module/user'
import { sendSaveReviews } from '@/api/module/reviews'
import { useRoute, useRouter } from 'vue-router'
const route = useRoute()
const router = useRouter()
const BASE_URL = import.meta.env.VITE_LOCAL_SERVE_IMGE_URL
const text = ref('')
const fileList = ref([])
const reviews = reactive({
  rate: 1,
  message: '',
  image: []
})
const onSubmit = async (val) => {
  const data = {
    rating: reviews.rate,
    text: text.value,
    image: reviews.image.join(',')
  }
  if (route.query.dishId) {
    data.dishId = route.query.dishId
  } else {
    data.setmealId = route.query.setmealId
  }
  const res = await sendSaveReviews(data)
  if (res.code === 1) {
    Toast.success('评论成功')
    router.back()
  } else {
    Toast.fail(res.msg)
  }
}
const beforeRead = (file) => {
  if (!file.type.includes('image')) {
    Toast('请上传图片')
    return false
  }
  return true
}
const afterRead = async (file) => {
  const imgFile = new FormData()
  imgFile.append('fileType', 'IMAGE')
  imgFile.append('file', file.file)
  const res = await sendUploadImage(imgFile)
  if (res.code === 1) {
    reviews.image.push(res.msg)
    Toast.success('上传成功')
  } else {
    Toast.fail('上传失败')
  }
}
</script>

<style scoped lang="scss">
.goods{
  .goods-info{
    margin-top: 8px;
    width: 100%;
    height: 40px;
    display: flex;
    margin-left: 16px;
    align-items: center;
    justify-content: flex-start;
    img{
      width: 40px;
      object-fit: cover;
      height: 40px;
      border-radius: 10px;
    }
    .name{
      margin-left: 20px;
      font-size: 12px;
    }
  }
}
</style>
