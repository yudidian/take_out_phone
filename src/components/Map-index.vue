<template>
  <div className="map">
    <el-amap
      ref="map"
      :center="center"
      :zoom="zoom"
      @init="init"
    />
  </div>
  <div>
    <van-cell
      v-for="item in addressList"
      :key="item"
      :title="item.address"
    />
  </div>
  <MyLoading :show="show" />
</template>

<script setup>
import { ref, reactive, shallowRef, defineEmits } from 'vue'
import { getDistances } from '@/utils/calculateDistance'

const emit = defineEmits(['getDistance'])
/** 地图实例    （shallowRef：如果有一个对象数据，后续功能不会修改该对象中的属性，而是生新的对象来替换） */
const myMap = shallowRef(null)
const show = ref(true)
/** 地图中心点（默认） */
const center = reactive([121.59996, 31.197646])
// 地址列表
let addressList = reactive([])
// 地图返回的地址信息
const formattedAddress = ref('')
/** 地图缩放级别（默认） */
const zoom = ref(15)
const init = (map) => {
  const AMap = window.AMap
  myMap.value = map
  getUserPosition(AMap)
  show.value = false
}
// 计算两地距离
const computedLine = (lat2, lng2, lat1 = 121.59996, lng1 = 31.197646) => {
  const res = getDistances(lat2, lng2, lat1, lng1)
  emit('getDistance', res.distance)
}
/** 添加地图标记点 */
const addMarker = AMap => {
  let marker = null
  AMap.plugin('AMap.Marker', function () {
    marker = new AMap.Marker({
      position: center
    })
    myMap.value.add(marker)
  })
}
/** 高德地图获取当前用户位置 */
const getUserPosition = AMap => {
  let Geolocation = null
  AMap.plugin('AMap.Geolocation', function () {
    // 异步加载插件
    Geolocation = new AMap.Geolocation({
      // 是否使用高精度定位，默认：true
      enableHighAccuracy: true,
      // 设置定位超时时间，默认：无穷大
      timeout: 6000,
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
      if (status === 'complete') {
        onComplete(result)
      } else {
        onError(result)
      }
    })

    function onComplete (res) {
      const { position } = res
      center[0] = position.lng
      center[1] = position.lat
      addMarker(AMap)
      computedLine(center[0], center[1])
      getAdd()
    }

    function onError (err) {
      console.log('获取位置失败:', err)
    }
  })
}
/** 地图加载完成后 （根据经纬度获取地址） */
const getAdd = () => {
  const AMap = window.AMap
  let geocoder
  AMap.plugin('AMap.Geocoder', function () {
    geocoder = new AMap.Geocoder({
      radius: 1000,
      extensions: 'all'
    })
  })
  const [lng, lat] = center
  geocoder.getAddress([lng, lat], function (status, result) {
    console.log(status, result)
    if (status === 'complete' && result.info === 'OK') {
      if (result && result.regeocode) {
        addressList = result.aois
        formattedAddress.value = result.regeocode.formattedAddress
      }
    }
  })
}
</script>

<style lang="scss" scoped>
.map {
  width: 100vw;
  height: 200px;

  :deep(.amap-marker) {
    width: 20px;
  }
}
</style>
