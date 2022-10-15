import request from '@/api/request'
// 获取商品详情
export const sendGoodsInfo = (id) => {
  return request({
    url: `/dish/${id}`,
    method: 'get'
  })
}
// 改变收藏状态值
export const sendChangeFavorites = (data) => {
  return request({
    url: '/favorites/change',
    method: 'get',
    params: data
  })
}
// 改变收藏状态值
export const sendGetFavorites = (id) => {
  return request({
    url: `/favorites/${id}`,
    method: 'get'
  })
}
