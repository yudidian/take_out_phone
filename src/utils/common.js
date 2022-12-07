import dayjs from 'dayjs'
export function debounce (fn, delay) {
  let timer = null
  return function (e) {
    // 取消之前的延时调用，每当用户输入的时候把前一个setTimeout清除
    clearTimeout(timer)
    timer = setTimeout(() => {
      fn(e)
    }, delay) // 直至delay时间后，监听的事件没有改变后，才会执行fn()
  }
}
export function throttle (fn, delay) {
  let canRun = true // 通过闭包保存一个标记
  return function () {
    // 在函数开头判断标记是否为true，不为true则return
    if (!canRun) return
    // 立即设置为false
    canRun = false
    // 将外部传入的函数的执行放在setTimeout中
    setTimeout(() => {
      // 最后在setTimeout执行完毕后再把标记设置为true(关键)表示可以执行下一次循环了。
      // 当定时器没有执行的时候标记永远是false，在开头被return掉
      fn.apply(this, arguments)
      canRun = true
    }, delay)
  }
}
export const isWeiXin = function () {
  // window.navigator.userAgent属性包含了浏览器类型、版本、操作系统类型、浏览器引擎类型等信息，这个属性可以用来判断浏览器类型
  const ua = window.navigator.userAgent.toLowerCase()
  const reg = /micromessenger|WeChat/i
  return reg.test(ua)
}
export const formatDate = (time) => {
  return dayjs(time).format('YYYY-MM-DD HH:mm:ss')
}
