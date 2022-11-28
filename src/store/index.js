import { createStore } from 'vuex'
import getters from './getters'
import user from './module/user'
import keepRouters from './module/keepRouters'
export default createStore({
  namespace: true,
  state () {
    return {
      showLoading: false
    }
  },
  mutations: {
    changShowLoading (state, value) {
      state.showLoading = value
    }
  },
  getters,
  modules: {
    user,
    keepRouters
  }
})
