export default {
  namespace: true,
  state () {
    return {
      keepAlive: []
    }
  },
  mutations: {
    setRouters (state, value) {
      if (value.router) {
        const index = state.keepAlive.findIndex((item) => item === value.router)
        if (value.flag === 'add') {
          if (index === -1) {
            state.keepAlive.push(value.router)
          }
        } else {
          if (index !== -1) {
            state.keepAlive.splice(index, 1)
          }
        }
      }
      console.log(state.keepAlive)
    }
  },
  actions: {
    async saveOrRemoveRouters ({ commit }, data) {
      commit('setRouters', data)
    }
  }
}
