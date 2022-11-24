import { createRouter, createWebHashHistory } from 'vue-router'
import store from '@/store'

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
    name: 'LayoutPage',
    children: [
      {
        path: '/home',
        name: 'HomePage',
        meta: {
          index: 1,
          title: '首页',
          keepAlive: true
        },
        component: () => import('@/views/home/HomePage.vue')
      },
      {
        path: '/cart',
        name: 'CartPage',
        meta: {
          index: 2,
          title: '购物车'
        },
        component: () => import('@/views/cart/CartPage.vue')
      },
      {
        path: '/mine',
        name: 'PersonalCenter',
        meta: {
          index: 3,
          title: '个人中心',
          keepAlive: true
        },
        component: () => import('@/views/mine/PersonalCenter.vue')
      }
    ]
  },
  {
    path: '/address',
    name: 'AddressPage',
    meta: {
      index: 5,
      title: '地址管理'
    },
    component: () => import('@/views/mine/components/AddressPage.vue')
  },
  {
    path: '/address/add',
    name: 'AddressAdd',
    meta: {
      index: 6,
      title: '地址编辑'
    },
    beforeEnter: (to, from, next) => {
      if (from.path !== '/address') {
        next('/address')
      } else {
        next()
      }
    },
    component: () => import('@/views/mine/components/AddressAdd.vue')
  },
  {
    path: '/address/choose',
    name: 'AddressChoose',
    component: () => import('@/views/Settlement/component/AddressChoose.vue'),
    meta: {
      index: 7,
      title: '地址选择',
      keepAlive: true
    }
  },
  {
    path: '/goods/detail/:id',
    name: 'GoodsDetail',
    meta: {
      index: 8,
      title: '商品详情',
      keepAlive: true
    },
    component: () => import('@/views/goodsDetail/GoodsDetail.vue')
  },
  {
    path: '/settlement',
    name: 'SettlementPage',
    component: () => import('@/views/Settlement/SettlementPage.vue'),
    beforeEnter: (to, from, next) => {
      if (from.path !== '/cart') {
        next('/cart')
      } else {
        next()
      }
    },
    meta: {
      title: '提交订单',
      keepAlive: false,
      index: 9
    }
  },
  {
    path: '/user/setting',
    name: 'UserSetting',
    component: () => import('@/views/mine/UserSetting/UserSetting.vue'),
    meta: {
      title: '用户信息编辑',
      keepAlive: false,
      index: 10
    }
  },
  {
    path: '/setting',
    name: 'SettingPage',
    component: () => import('@/views/Setting/SettingPage.vue'),
    meta: {
      title: '用户设置',
      keepAlive: false,
      index: 11
    }
  },
  {
    path: '/history/orders',
    name: 'HistoryOrders',
    component: () => import('@/views/mine/HistoryOrders/HistoryOrders.vue'),
    meta: {
      title: '历史订单',
      keepAlive: false,
      index: 12
    }
  },
  {
    path: '/pendingReceipt',
    name: 'PendingReceipt',
    component: () => import('@/views/mine/PendingReceipt/PendingReceipt.vue'),
    meta: {
      title: '待收货',
      keepAlive: false,
      index: 14
    }
  },
  {
    path: '/reviewsList',
    name: 'ReviewsList',
    beforeEnter: (to, from, next) => {
      if (!from.path.includes('/goods/detail')) {
        next('/')
      } else {
        next()
      }
    },
    component: () => import('@/views/ReviewsList/ReviewsList.vue'),
    meta: {
      title: '商品评论列表',
      keepAlive: false,
      index: 15
    }
  },
  {
    path: '/writeReview',
    name: 'WriteReview',
    component: () => import('@/views/WriteReview/WriteReview.vue'),
    meta: {
      title: '写商品评论',
      keepAlive: false,
      index: 16
    }
  },
  {
    path: '/storeUp',
    name: 'StoreUp',
    component: () => import('@/views/StoreUp/StoreUp.vue'),
    meta: {
      title: '写商品评论',
      keepAlive: false,
      index: 16
    }
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
  // 如果结算页面去选择地址则缓存该路由
  if (from.name === 'SettlementPage' && to.name === 'AddressChoose') {
    store.dispatch('addParentRouters', 'SettlementPage')
  }
  if (from.name === 'SettlementPage' && (to.name === 'CartPage' || to.name === 'PersonalCenter')) {
    store.dispatch('removeParentRouters', 'SettlementPage')
  }
  next()
})
export default myRouter
