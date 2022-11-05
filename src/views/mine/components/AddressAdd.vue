<template>
  <NavBar
    :title="$route.query.id ? '编辑地址' : '新增地址'"
    left-text="返回"
    left-arrow
    @click-left="$router.back()"
  />
  <AddressEdit
    :address-info="addressInfo"
    ref="addAddressEdit"
    :area-list="areaList"
    :show-postal="false"
    :show-delete="false"
    :show-set-default="false"
    show-search-result
    :search-result="searchResult"
    :area-columns-placeholder="['请选择', '请选择', '请选择']"
    @save="onSave"
    @change-detail="onChangeDetail"
  >
    <template #default>
      <div class="address-tag">
        <span class="name">标签</span>
        <RadioGroup
          v-model="checked"
          direction="horizontal"
          :icon-size="16"
        >
          <Radio name="无">
            无
          </Radio>
          <Radio name="公司">
            公司
          </Radio>
          <Radio name="家">
            家
          </Radio>
          <Radio name="学校">
            学校
          </Radio>
        </RadioGroup>
      </div>
    </template>
  </AddressEdit>
</template>

<script setup name="AddressAdd">
import { useRouter, useRoute } from 'vue-router'
import { AddressEdit, NavBar, Radio, RadioGroup, Toast } from 'vant'
import { onMounted, ref } from 'vue'
import {
  addAddress,
  getAddress,
  sendUpdateAddress
} from '@/api/module/address'
import { areaList } from '@vant/area-data'
const checked = ref('无')
onMounted(() => {
  if (route.query.id) {
    getAddressById(route.query.id)
  }
})
const route = useRoute()
const router = useRouter()
const addAddressEdit = ref(null)
const searchResult = ref([])
const addressInfo = ref({})
// 保存
const onSave = async (content) => {
  const info = {
    consignee: content.name,
    phone: content.tel,
    provinceName: content.province,
    cityName: content.city,
    districtCode: content.areaCode,
    districtName: content.county,
    detail: content.addressDetail,
    label: checked.value
  }
  let res
  if (route.query.id) {
    info.id = content.id
    res = await sendUpdateAddress(info)
  } else {
    res = await addAddress(info)
  }
  if (res.code === 1) {
    Toast.success(res.msg)
    await router.replace('/address')
  } else {
    Toast.fail(res.msg)
  }
}
const onChangeDetail = (val) => {
  if (val) {
    searchResult.value = [
      {
        name: '黄龙万科中心',
        address: '杭州市西湖区'
      }
    ]
  } else {
    searchResult.value = []
  }
}

const getAddressById = async (id) => {
  const res = await getAddress(id)
  addressInfo.value = {
    id: res.info.id,
    name: res.info.consignee,
    tel: res.info.phone,
    province: res.info.provinceName,
    city: res.info.cityName,
    areaCode: res.info.districtCode,
    county: res.info.districtName,
    addressDetail: res.info.detail
  }
  checked.value = res.info.label
}
</script>

<style scoped lang="scss">
.address-tag {
  display: flex;
  align-items: center;
  width: 100%;
  height: 60px;
  font-size: 14px;
  background-color: #ffffff;
  .name {
    margin: 0 14px;
  }
}
</style>
