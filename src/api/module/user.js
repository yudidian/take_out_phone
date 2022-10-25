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
// 获取用户信息
export const sendGetUserInfo = () => {
  return request({
    url: '/user',
    method: 'get'
  })
}
// 上传头像
export const sendUploadImage = (formData) => {
  return request.post('/upload', formData, {
    'Content-type': 'multipart/form-data'
  })
}
// 上传头像
export const sendUploadUserInfo = (data) => {
  return request({
    method: 'PUT',
    url: '/user',
    data
  })
}
// 获取用户最新订单
export const sendGetNewOrders = () => {
  return request({
    method: 'get',
    url: '/orders/latest'
  })
}
