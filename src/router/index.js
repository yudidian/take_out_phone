import { createRouter, createWebHashHistory } from 'vue-router'

const routes = [
  {
    path: '/login',
    name: 'login',
    component: () => import('@/views/login/LoginPage.vue')
  },
  {
    path: '/',
    component: () => import('@/layout/LayoutPage.vue'),
    redirect: '/home',
    children: [
      {
        path: 'home',
        name: 'home',
        meta: {
          index: 'home',
          title: '首页'
        },
        component: () => import('@/views/home/HomePage.vue')
      },
      {
        path: 'cart',
        name: 'cart',
        meta: {
          index: 'cart',
          title: '购物车'
        },
        component: () => import('@/views/cart/cart-index.vue')
      },
      {
        path: 'mine',
        name: 'mine',
        meta: {
          index: 'mine',
          title: '个人中心'
        },
        component: () => import('@/views/mine/PersonalCenter.vue')
      }
    ]
  },
  {
    path: '/address',
    name: 'Address',
    component: () => import('@/views/mine/components/AddressPage.vue')
  },
  {
    path: '/address-add',
    name: 'Address-add',
    beforeEnter: (to, from, next) => {
      if (from.path !== '/address') {
        next('/address')
      }
      next()
    },
    component: () => import('@/views/mine/components/AddressAdd.vue')
  },
  {
    path: '/goods/detail',
    name: 'goodsDetail',
    component: () => import('@/views/goodsDetail/GoodsDetail.vue')
  }
]

const myRouter = createRouter({
  history: createWebHashHistory(),
  routes
})
myRouter.beforeEach((to, from, next) => {
  if (to.meta.title) {
    document.title = to.meta.title
  }
  next()
})
export default myRouter
