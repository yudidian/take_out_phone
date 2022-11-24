import axios from 'axios'
import { Notify } from 'vant'
import router from '@/router/index'
import store from '@/store'
const request = axios.create({
  baseURL: '/api',
  timeout: 100000
})
request.interceptors.request.use(
  (config) => {
    store.dispatch('changShowLoading', true)
    // get请求映射params参数
    const token = localStorage.getItem('token')
    if (token) {
      config.headers.token = token
    }
    return config
  },
  (error) => {
    store.dispatch('changShowLoading', false)
    Promise.reject(error)
  }
)

request.interceptors.response.use(
  (res) => {
    store.dispatch('changShowLoading', false)
    if (res.data.msg.includes('token')) {
      // 登录过期的时候清除路由对HomePage的缓存
      store.dispatch('removeChildRouters', 'HomePage')
      if (router.currentRoute.value.path !== '/login') {
        store.commit('setUserAction', router.currentRoute.value.fullPath)
      }
      Notify({
        message: '用户信息过期',
        type: 'warning'
      })
      router.replace('/login')
    }
    return res.data
  },
  (error) => {
    console.log(error)
    store.dispatch('changShowLoading', false).then((r) => {
    })
    let { message } = error
    if (message === 'Network Error') {
      message = '后端接口连接异常'
    } else if (message.includes('timeout')) {
      message = '系统接口请求超时'
    } else if (message.includes('Request failed with status code 403')) {
      message = error.response.data.msg
      router.push('/login')
    } else if (message.includes('Request failed with status code')) {
      message = '系统接口异常'
    }
    Notify({
      message,
      type: 'warning'
    })
  }
)
export default request
