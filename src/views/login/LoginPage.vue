<template>
  <NavBar
    title="登录"
  />
  <Form @submit="onSubmit">
    <CellGroup inset>
      <Field
        v-model="form.phone"
        :label-width="60"
        name="用户名"
        label="用户名"
        placeholder="用户名"
        :rules="[{ required: true, message: '请填写用户名' }]"
      >
        <template #button>
          <Button
            size="small"
            type="primary"
            ref="code"
            block
            @click="sendCodeHandler"
          >
            发送验证码
          </Button>
        </template>
      </Field>
      <Field
        v-model="form.code"
        :label-width="60"
        name="验证码"
        label="验证码"
        placeholder="验证码"
        :rules="[{ required: true, message: '请填验证码' },{validator,message: '验证码为6位'}]"
      />
    </CellGroup>
    <div style="margin: 16px;">
      <Button
        round
        block
        type="primary"
        native-type="submit"
      >
        登录
      </Button>
    </div>
  </Form>
  <Slider
    v-if="isSlider"
    @checkFlag="checkFlagHandler"
  />
  <Overlay :show="show">
    <template #default>
      <div class="loading-warpper">
        <Loading :size="30" />
      </div>
    </template>
  </Overlay>
</template>

<script setup>
import { Form, Field, CellGroup, Button, NavBar, Notify, Overlay, Loading } from 'vant'
import Slider from './components/SliderIndex.vue'
import { onBeforeUnmount, ref } from 'vue'
import { sendCode } from '@/api/module/user'
import { useStore } from 'vuex'

const show = ref(false)
const store = useStore()
const time = ref(60)
const code = ref(null)
const form = ref({
  phone: '1554254032@qq.com',
  code: 'xolu5f'
})
const isSlider = ref(false)
// 表单提交
const onSubmit = () => {
  store.dispatch('toLogin', form.value)
}
// 发送验证码
const sendCodeHandler = () => {
  isSlider.value = true
}
const checkFlagHandler = async (val) => {
  if (val) {
    isSlider.value = false
    show.value = true
    const res = await sendCode({
      email: form.value.phone
    })
    show.value = false
    if (res.code === 1) {
      Notify({
        type: 'success',
        message: '发送成功'
      })
      const timer = setInterval(() => {
        if (time.value > 0) {
          time.value--
          code.value.$el.innerText = time.value + 's'
        } else {
          clearInterval(timer)
          code.value.$el.innerText = '发送验证码'
        }
      }, 1000)
    } else {
      Notify({
        type: 'danger',
        message: '发送失败'
      })
    }
  }
}
const validator = (val) => {
  console.log(/^[a-zA-z0-9]{6}$/.test(val))
  return /^[a-zA-z0-9]{6}$/.test(val)
}
// 组件销毁时清除所有定时器
onBeforeUnmount(() => {
  const lend = setInterval(() => {
    for (let i = 0; i < lend; i++) {
      clearInterval(i)
    }
  })
})

</script>

<style scoped lang="scss">
.van-form{
  margin-top: 20px;
  .van-cell-group{
    .van-field{
      :deep(.van-field__label){
        display: flex;
        align-items: center;
      }
    }
  }
}
.van-overlay{
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>
