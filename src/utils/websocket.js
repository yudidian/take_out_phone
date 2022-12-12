import { Toast } from 'vant'
export default class SocketService {
  constructor (url) {
    this.url = url
    this.connect()
  }

  static instance = null
  static get Instance () {
    if (!this.instance) {
      this.instance = new SocketService()
    }
    return this.instance
  }

  // 和服务端连接的socket对象
  ws = null
  // 存储回调函数
  callBackMapping = {}
  // 标识是否连接成功
  connected = false
  // 记录重试的次数
  sendRetryCount = 0
  // 重新连接尝试的次数
  connectRetryCount = 0
  //  定义连接服务器的方法
  connect () {
    // 连接服务器
    if (!window.WebSocket) {
      Toast.fail('您的浏览器不支持WebSocket')
      return
    }
    this.ws = new WebSocket(this.url)
    // 连接成功的事件
    this.ws.onopen = () => {
      this.connected = true
      // 重置重新连接的次数
      this.connectRetryCount = 0
    }
  }

  // 回调函数的注册
  registerCallBack (socketType, callBack) {
    this.callBackMapping[socketType] = callBack
  }

  // 取消某一个回调函数
  unRegisterCallBack (socketType) {
    this.callBackMapping[socketType] = null
  }

  // 发送数据的方法
  send (data) {
    // 判断此时此刻有没有连接成功
    if (this.connected) {
      this.sendRetryCount = 0
      try {
        this.ws.send(JSON.stringify(data))
      } catch (e) {
        this.ws.send(data)
      }
    } else {
      this.sendRetryCount++
      setTimeout(() => {
        this.send(data)
      }, this.sendRetryCount * 500)
    }
  }

  // 获取数据
  getMessage () {
    this.ws.onmessage = msg => {
      const res = JSON.parse(msg.data)
      if (res.flag !== undefined && !res.flag) {
        Toast.fail({
          duration: 0,
          closeOnClick: true,
          overlay: true,
          message: res.msg,
          onClose: () => {
            window.open('about:blank', '_self')
            window.close()
          }
        })
      }
    }
  }
}
