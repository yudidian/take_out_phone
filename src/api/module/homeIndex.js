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
