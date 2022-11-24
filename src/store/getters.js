export default {
  token: (state) => {
    return state.user.token
  },
  showLoading: (state) => {
    return state.showLoading
  },
  userId: (state) => {
    return state.user.userId
  },
  childKeepalive: (state) => {
    return state.keepRouters.childKeepAliveRouters
  },
  parentKeepalive: (state) => {
    return state.keepRouters.parentKeepAliveRouters
  },
  action: (state) => state.user.action
}
