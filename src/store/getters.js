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
  keepalive: (state) => {
    return state.keepRouters.keepAliveRouters
  }
}
