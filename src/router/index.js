import { createRouter, createWebHashHistory } from 'vue-router'

const routes = [
  {
    path: '/login',
    name: 'login',
    component: () => import('@/views/login/login-index.vue')
  },
  {
    path: '/',
    component: () => import('@/layout/layout-index.vue'),
    redirect: '/home',
    children: [
      {
        path: 'home',
        name: 'home',
        meta: {
          index: 'home',
          title: '首页'
        },
        component: () => import('@/views/home/home-index.vue')
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
        component: () => import('@/views/mine/mine-index.vue')
      }
    ]
  },
  {
    path: '/address',
    name: 'Address',
    component: () => import('@/views/mine/components/address-index.vue')
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
    component: () => import('@/views/mine/components/address-add.vue')
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
