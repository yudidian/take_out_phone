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
    // 一个页面有大量请求时只展示一次遮罩
    if (!store.getters.showLoading) {
      store.commit('changShowLoading', true)
    }
    // get请求映射params参数
    const token = localStorage.getItem('token')
    if (token) {
      config.headers.token = token
    }
    return config
  },
  (error) => {
    store.commit('changShowLoading', false)
    Promise.reject(error)
  }
)

request.interceptors.response.use(
  (res) => {
    store.commit('changShowLoading', false)
    if (res.data.msg.includes('token')) {
      // 登录过期的时候清除路由对HomePage的缓存
      store.dispatch('removeChildRouters', 'HomePage')
      store.dispatch('removeParentRouters', 'LayoutPage')
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
    store.commit('changShowLoading', false)
    // 登录过期的时候清除路由对HomePage的缓存
    store.dispatch('removeChildRouters', 'HomePage')
    store.dispatch('removeParentRouters', 'LayoutPage')
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
