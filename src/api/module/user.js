import request from '@/api/request'

// 登录
export const login = (data) => {
  return request({
    url: '/user/login',
    method: 'POST',
    data
  })
}
// 发送验证码
export const sendCode = (params) => {
  return request({
    url: '/email',
    method: 'GET',
    params
  })
}
// 注册
export const register = (data) => {
  return request({
    url: '/user/register',
    method: 'POST',
    data
  })
}
