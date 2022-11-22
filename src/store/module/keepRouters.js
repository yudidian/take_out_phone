export default {
  namespace: true,
  state () {
    return {
      childKeepAliveRouters: ['HomePage'],
      parentKeepAliveRouters: ['LayoutPage']
    }
  },
  mutations: {
    addChildRouters (state, routerName) {
      const index = state.childKeepAliveRouters.findIndex(item => item === routerName)
      if (index !== -1) return
      state.childKeepAliveRouters.push(routerName)
    },
    removeChildRouters (state, routerName) {
      const index = state.childKeepAliveRouters.findIndex(item => item === routerName)
      state.childKeepAliveRouters.splice(index, 1)
    },
    addParentRouters (state, routerName) {
      const index = state.parentKeepAliveRouters.findIndex(item => item === routerName)
      if (index !== -1) return
      state.parentKeepAliveRouters.push(routerName)
    },
    removeParentRouters (state, routerName) {
      const index = state.parentKeepAliveRouters.findIndex(item => item === routerName)
      state.parentKeepAliveRouters.splice(index, 1)
    }
  },
  actions: {
    async addChildRouters ({ commit }, routerName) {
      commit('addChildRouters', routerName)
    },
    async removeChildRouters ({ commit }, routerName) {
      commit('removeChildRouters', routerName)
    },
    async addParentRouters ({ commit }, routerName) {
      commit('addParentRouters', routerName)
    },
    async removeParentRouters ({ commit }, routerName) {
      commit('removeParentRouters', routerName)
    }
  }
}
