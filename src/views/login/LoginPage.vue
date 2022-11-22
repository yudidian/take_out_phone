<template>
  <div class="content">
    <div class="title">
      Koala
    </div>
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
          :rules="[
            { required: true, message: '请填验证码' },
            { validator, message: '验证码为6位' },
          ]"
        />
      </CellGroup>
      <div style="margin: 16px">
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
  </div>
</template>

<script setup name="LoginPage">
import { Form, Field, CellGroup, Button, Notify } from 'vant'
import { onBeforeUnmount, ref } from 'vue'
import { sendCode } from '@/api/module/user'
import { useStore } from 'vuex'
const store = useStore()
const time = ref(60)
const code = ref(null)
const form = ref({
  phone: '1554254032@qq.com',
  code: ''
})
// 表单提交
const onSubmit = () => {
  store.dispatch('toLogin', form.value)
}
// 发送验证码
const sendCodeHandler = async () => {
  const res = await sendCode({
    email: form.value.phone
  })
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
const validator = (val) => {
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
.content {
  position: relative;
  width: 100%;
  height: 100vh;
  overflow: hidden;
  background: url("../../assets/image/veer-402681504.jpg") no-repeat;
  background-size: cover;
  &::before {
    content: "";
    position: fixed;
    top: 0;
    left: 0;
    bottom: 0;
    right: 0;
    backdrop-filter: blur(5px);
    z-index: 1;
  }
}
.title {
  position: absolute;
  top: 25%;
  z-index: 9;
  width: 100%;
  height: 40px;
  text-align: center;
  font-size: 36px;
  font-weight: 900;
  animation: tracking-in-contract 2.5s cubic-bezier(0.215, 0.61, 0.355, 1) both;
}
.van-form {
  position: absolute;
  top: 40%;
  left: 50%;
  z-index: 9;
  width: 100%;
  height: 120px;
  transform: translate(-50%, -50%);
  margin-top: 20px;
  .van-cell-group {
    .van-field {
      :deep(.van-field__label) {
        display: flex;
        align-items: center;
      }
    }
  }
}
.van-overlay {
  display: flex;
  justify-content: center;
  align-items: center;
}
@keyframes tracking-in-contract {
  0% {
    letter-spacing: 1em;
    opacity: 0;
  }
  40% {
    opacity: 0.6;
  }
  100% {
    letter-spacing: normal;
    opacity: 1;
  }
}
</style>
