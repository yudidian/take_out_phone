import request from '@/api/request'
// 获取商品详情
export const sendGoodsInfo = (id) => {
  return request({
    url: `/dish/${id}`,
    method: 'get'
  })
}
// 获取商品详情
export const sendSetmealInfo = (id) => {
  return request({
    url: `/setmeal/${id}`,
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
export const sendGetFavorites = (id, type) => {
  return request({
    url: `/favorites/${id}/${type}`,
    method: 'get'
  })
}
// 添加进购物车
export const sendAddCart = (data) => {
  return request({
    url: '/cart/add',
    method: 'post',
    data
  })
}
// 获取购物车列表
export const sendGetCartList = () => {
  return request({
    url: '/cart/list',
    method: 'get'
  })
}
// 清空购物车
export const sendDeleteCartAll = () => {
  return request({
    url: '/cart/delete/all',
    method: 'delete'
  })
}
// 菜品数量-1
export const sendLessCartCount = (data) => {
  return request({
    url: '/cart/less',
    method: 'put',
    data
  })
}
// 删除菜品
export const sendDeleteCartOne = (data) => {
  return request({
    url: '/cart/delete/one',
    method: 'put',
    data
  })
}
/**
 * 获取菜品描述
 * @param id 菜品ID
 * @returns {*}
 */
export const sendGetDishDescription = (id) => {
  return request({
    url: `/goods/description/${id}`,
    method: 'get'
  })
}
export const sendGetStoreUpList = (params) => {
  return request({
    url: '/favorites/list',
    method: 'get',
    params
  })
}
