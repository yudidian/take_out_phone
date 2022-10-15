import { login } from '@/api/module/user'
import { Notify } from 'vant'
import router from '@/router/index'

export default {
  namespace: true,
  state () {
    return {
      token: localStorage.getItem('token') || '',
      userId: localStorage.getItem('userId') || ''
    }
  },
  mutations: {
    setToken (state, value) {
      state.token = value.token
      state.userId = value.id
    }
  },
  actions: {
    async toLogin ({ commit }, data) {
      const res = await login(data)
      if (res.code === 1) {
        commit('setToken', res.info)
        localStorage.setItem('token', res.info.token)
        localStorage.setItem('userId', res.info.userId)
        await router.replace('/')
        Notify({
          type: 'success',
          message: '登录成功'
        })
      } else {
        Notify({
          type: 'danger',
          message: res.msg
        })
      }
    }
  }
}
