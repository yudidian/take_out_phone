import { createStore } from 'vuex'
import getters from './getters'
import user from './module/user'
export default createStore({
  namespace: true,
  state () {
    return {
      showLoading: false
    }
  },
  mutations: {
    setShowLoading (state, value) {
      state.showLoading = value
    }
  },
  actions: {
    changShowLoading ({ commit }, value) {
      commit('setShowLoading', value)
    }
  },
  getters,
  modules: {
    user
  }
})
