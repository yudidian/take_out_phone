import { Notify } from 'vant'
import { reactive, ref } from 'vue'
import { getDistances } from '@/utils/calculateDistance'

const useMap = (AMap) => {
  // 用户经纬度
  const center = reactive([])
  // 两地距离
  const distance = ref(0)
  // 地址列表
  const addressList = ref([])
  // 当前位置
  const formattedAddress = ref('')
  /** 地图加载完成后 （根据经纬度获取地址） */
  const getUserPosition = (AMap) => {
    // 异步加载插件
    const Geolocation = new AMap.Geolocation({
      // 是否使用高精度定位，默认：true
      enableHighAccuracy: false,
      // 设置定位超时时间，默认：无穷大
      timeout: 10,
      useNative: true,
      // 定位按钮的停靠位置的偏移量
      offset: [10, 20],
      panToLocation: true,
      //  定位成功后调整地图视野范围使定位位置及精度范围视野内可见，默认：false
      zoomToAccuracy: true,
      //  定位按钮的排放位置,  RB表示右下
      position: 'RB'
    })
    Geolocation.getCurrentPosition((status, result) => {
      console.log(status, result)
      if (status === 'complete') {
        const { position } = result
        center[0] = position.lng
        center[1] = position.lat
      } else {
        // 危险通知
        Notify({ type: 'danger', message: '获取失败' })
      }
    }, (res) => {
      console.log(res)
    })
  }
  const getAddress = (AMap, center) => {
    AMap &&
      AMap.plugin('AMap.Geocoder', function () {
        const geocoder = new AMap.Geocoder({
          radius: 1000,
          extensions: 'all'
        })
        const [lng, lat] = center
        geocoder.getAddress([lng, lat], function (status, result) {
          if (status === 'complete' && result.info === 'OK') {
            if (result && result.regeocode) {
              addressList.value = result.regeocode.pois
              formattedAddress.value = result.regeocode.formattedAddress
            }
          }
        })
      })
  }
  // 根据两地经纬度计算两地之间的距离
  // 计算两地距离
  const computedLine = (lat2, lng2, lat1 = 121.59996, lng1 = 31.197646) => {
    const res = getDistances(lat2, lng2, lat1, lng1)
    distance.value = res.distance
  }
  return {
    distance,
    addressList,
    formattedAddress,
    center,
    getUserPosition,
    getAddress,
    computedLine
  }
}
export default useMap
