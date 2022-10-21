import request from '@/api/request'

// 登录
export const sendSubmitOrders = (params) => {
  return request({
    url: '/orders',
    method: 'get',
    params
  })
}
