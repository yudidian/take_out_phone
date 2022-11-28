import lodash from 'lodash'
import { ref } from 'vue'
const useScroll = () => {
  const isShowScroll = ref(false)
  const ScrollTop = ref(0)
  let timer
  const listenScroll = (tag) => {
    scroll.value = tag
    tag.addEventListener('scroll', lodash.throttle(function (e) {
      ScrollTop.value = e.target.scrollTop
      isShowScroll.value = e.target.scrollTop >= 10
    }, 200))
  }
  const returnTop = (tag) => {
    timer = setInterval(() => {
      if (ScrollTop.value <= 0) {
        tag.scrollTop = 0
        clearInterval(timer)
      } else {
        tag.scrollTop = ScrollTop.value
      }
      ScrollTop.value -= (ScrollTop.value / 5)
    }, 10)
  }
  return {
    listenScroll,
    isShowScroll,
    returnTop
  }
}
export default useScroll
