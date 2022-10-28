import request from '@/api/request'

// 登录
export const sendSaveReviews = (data) => {
  return request({
    url: '/reviews',
    method: 'POST',
    data
  })
}
