export default {
  namespace: true,
  state () {
    return {
      keepAliveRouters: ['LayoutPage']
    }
  },
  mutations: {
    setRouters (state, routerName) {
      const index = state.keepAliveRouters.findIndex(item => item === routerName)
      if (index === -1) {
        state.keepAliveRouters.push(routerName)
      } else {
        state.keepAliveRouters.splice(index, 1)
      }
    }
  },
  actions: {
    async saveOrRemoveRouters ({ commit }, routerName) {
      commit('setRouters', routerName)
    }
  }
}
