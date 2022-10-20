<template>
  <div class="map-content">
    <Search
      class="map-search"
      shape="round"
      v-model="addressInfo"
      placeholder="请输入搜索关键词"
    />
    <div class="map">
      <el-amap
        ref="map"
        :center="center"
        :zoom="zoom"
        @init="init"
      />
    </div>
    <div class="address-list">
      <Cell
        style="width: 100%;"
        v-for="item in addressList"
        :key="item.id"
        :title="item.address"
        @click="changAddress(item)"
      />
    </div>
    <MyLoading :show="show" />
  </div>
</template>

<script setup name="MapPage">
import { ref, reactive, shallowRef, defineEmits, watch } from 'vue'
import { getDistances } from '@/utils/calculateDistance'
import { debounce } from '@/utils/common'
import { Cell, Notify, Search } from 'vant'
const emit = defineEmits(['getDistance'])
/** 地图实例 */
const myMap = shallowRef(null)
// 搜索实例
const MSearch = ref(null)
// 搜索关键字
const addressInfo = ref('')
const show = ref(true)
/** 地图中心点（默认） */
const center = reactive([121.59996, 31.197646])
// 地址列表
const addressList = ref([])
// 地图返回的地址信息
const formattedAddress = ref('')
/** 地图缩放级别（默认） */
const zoom = ref(15)

// 监听搜索信息变化
watch(addressInfo, () => {
  debounce(MSearch.value.search(addressInfo.value, (state, res) => {
    if (state === 'complete' && res.info === 'OK') {
      addressList.value = res.tips.map((item) => {
        return {
          ...item,
          address: item.name
        }
      })
    }
  }), 500)
})
// 初始化数据
const init = (map) => {
  const AMap = window.AMap
  myMap.value = map
  getUserPosition(AMap)
  show.value = false
  mapSearch(AMap)
}
// 点击地址时触发
const changAddress = (item) => {
  addressInfo.value = item.address
  center[0] = item.location.lng
  center[1] = item.location.lat
  computedLine(item.location.lat, item.location.lng)
  addMarker(window.AMap)
}
// 搜索功能
const mapSearch = (AMap) => {
  AMap.plugin(['AMap.AutoComplete'], function () {
    const PlaceSearchOptions = { // 设置PlaceSearch属性
      pageSize: 10, // 每页结果数,默认10
      pageIndex: 1, // 请求页码，默认1
      extensions: 'base' // 返回信息详略，默认为base（基本信息）
    }
    MSearch.value = new AMap.AutoComplete(PlaceSearchOptions) // 构造PlaceSearch类
  })
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
      // 危险通知
      Notify({ type: 'danger', message: err })
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
    if (status === 'complete' && result.info === 'OK') {
      if (result && result.regeocode) {
        addressList.value = result.regeocode.pois
        formattedAddress.value = result.regeocode.formattedAddress
      }
    }
  })
}
</script>

<style lang="scss" scoped>
.map-content{
  position: relative;
  .map-search{
  }
  .map {
    position: fixed;
    top: 54px;
    width: 100vw;
    height: 250px;
    :deep(.amap-marker) {
      width: 20px;
    }
  }
  .address-list{
    width: 100%;
    position: absolute;
    top: 304px;
    bottom: 50px;
    overflow-y: auto;
    height: calc(100vh - 354px);
  }
}

</style>
