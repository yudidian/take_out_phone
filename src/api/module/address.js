import request from '@/api/request'
// 获取地址列表
export const getAddressList = () => {
  return request({
    url: '/address/list',
    method: 'GET'
  })
}
// 获取默认地址
export const getDefaultAddress = () => {
  return request({
    url: '/address/default',
    method: 'GET'
  })
}

// 设置默认地址
export const setDefaultAddress = (id) => {
  return request({
    url: `/address/set/${id}`,
    method: 'GET'
  })
}
// 添加地址
export const addAddress = (data) => {
  return request({
    url: '/address',
    method: 'POST',
    data
  })
}
// 添加地址
export const getAddress = (id) => {
  return request({
    url: `/address/${id}`,
    method: 'get'
  })
}
// 修改地址
export const sendUpdateAddress = (data) => {
  return request({
    url: '/address',
    method: 'put',
    data
  })
}
