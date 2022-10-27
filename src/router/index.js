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
          index: 1,
          title: '首页',
          keepAlive: true
        },
        component: () => import('@/views/home/HomePage.vue')
      },
      {
        path: 'cart',
        name: 'cart',
        meta: {
          index: 2,
          title: '购物车'
        },
        component: () => import('@/views/cart/CartPage.vue')
      },
      {
        path: 'mine',
        name: 'mine',
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
    name: 'Address',
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
      }
      next()
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
    name: 'goodsDetail',
    meta: {
      index: 8,
      title: '商品详情',
      keepAlive: false
    },
    component: () => import('@/views/goodsDetail/GoodsDetail.vue')
  },
  {
    path: '/settlement',
    name: 'settlement',
    component: () => import('@/views/Settlement/SettlementPage.vue'),
    meta: {
      title: '提交订单',
      keepAlive: false,
      index: 9
    }
  },
  {
    path: '/user/setting',
    name: 'userSetting',
    component: () => import('@/views/mine/UserSetting/UserSetting.vue'),
    meta: {
      title: '用户信息编辑',
      keepAlive: false,
      index: 10
    }
  },
  {
    path: '/setting',
    name: 'setting',
    component: () => import('@/views/Setting/SettingPage.vue'),
    meta: {
      title: '用户设置',
      keepAlive: false,
      index: 11
    }
  },
  {
    path: '/history/orders',
    name: 'historyOrders',
    component: () => import('@/views/mine/HistoryOrders/HistoryOrders.vue'),
    meta: {
      title: '历史订单',
      keepAlive: false,
      index: 12
    }
  },
  {
    path: '/pendingReceipt',
    name: 'pendingReceipt',
    component: () => import('@/views/mine/PendingReceipt/PendingReceipt.vue'),
    meta: {
      title: '待收货',
      keepAlive: false,
      index: 14
    }
  },
  {
    path: '/reviewsList',
    name: 'reviewsList',
    component: () => import('@/views/ReviewsList/ReviewsList.vue'),
    meta: {
      title: '商品评论',
      keepAlive: false,
      index: 15
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
  next()
})
export default myRouter
