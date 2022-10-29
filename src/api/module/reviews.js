import request from '@/api/request'

// 写评论
export const sendSaveReviews = (data) => {
  return request({
    url: '/reviews',
    method: 'POST',
    data
  })
}
// 获取对应评论列表
export const sendGetReviewList = (data) => {
  return request({
    url: '/reviews/list',
    method: 'get',
    params: data
  })
}
// 获取对应评论列表各个数量
export const sendGetReviewCount = (data) => {
  return request({
    url: '/reviews/count',
    method: 'get',
    params: data
  })
}
