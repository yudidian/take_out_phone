import axios from 'axios'
import { Notify } from 'vant'
import router from '@/router/index'
const request = axios.create({
  baseURL: '/api',
  timeout: 10000
})
request.interceptors.request.use(config => {
  // get请求映射params参数
  const token = localStorage.getItem('token')
  if (token) {
    config.headers.token = token
  }
  return config
}, error => {
  Promise.reject(error)
})

request.interceptors.response.use(res => {
  return res.data
}, error => {
  let { message } = error
  if (message === 'Network Error') {
    message = '后端接口连接异常'
  } else if (message.includes('timeout')) {
    message = '系统接口请求超时'
  } else if (message.includes('Request failed with status code')) {
    message = '系统接口异常'
  } else if (message.includes('token')) {
    message = '登录异常请重新登录'
    router.push('/login')
  }
  Notify({
    message,
    type: 'warning'
  })
})
export default request
