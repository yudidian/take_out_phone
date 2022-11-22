export default {
  namespace: true,
  state () {
    return {
      keepAliveRouters: ['HomePage']
    }
  },
  mutations: {
    addRouters (state, routerName) {
      state.keepAliveRouters.push(routerName)
    },
    removeRouters (state, routerName) {
      const index = state.keepAliveRouters.findIndex(item => item === routerName)
      state.keepAliveRouters.splice(index, 1)
    }
  },
  actions: {
    async addRouters ({ commit }, routerName) {
      commit('addRouters', routerName)
    },
    async removeRouters ({ commit }, routerName) {
      commit('removeRouters', routerName)
    }
  }
}
