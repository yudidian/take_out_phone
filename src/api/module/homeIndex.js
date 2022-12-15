import request from '@/api/request'

export const getCategory = () => {
  return request({
    url: '/category/all',
    method: 'GET'
  })
}
export const getDish = (params) => {
  return request({
    url: '/dish/list',
    method: 'GET',
    params
  })
}
export const getSetmeal = (params) => {
  return request({
    url: '/setmeal/list',
    method: 'GET',
    params
  })
}
export const sendGetSwiperList = () => {
  return request({
    url: '/swiper',
    method: 'GET'
  })
}
