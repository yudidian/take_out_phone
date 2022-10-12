<template>
  <NavBar
    title="地址详情"
    left-text="返回"
    left-arrow
    @click-left="$router.back()"
  />
  <AddressList
    :switchable="false"
    :list="addressList"
    default-tag-text="默认地址"
    @add="$router.push('/address-add')"
    @edit="onEdit"
  >
    <template #item-bottom="score">
      <Cell
        class="set-default"
        center
        title="设置为默认地址"
      >
        <template #right-icon>
          <Switch
            :model-value="score.isDefault"
            @update:model-value="score.isDefault"
            size="20"
            active-color="#ee0a24"
            inactive-color="#dcdee0"
            @click="setDefaultHandler(score.id)"
          />
        </template>
      </Cell>
    </template>
  </AddressList>
  <my-loading :show="isLoading" />
</template>
<script setup>
import {
  AddressList,
  NavBar,
  Cell,
  Switch
} from 'vant'
import { useRouter } from 'vue-router'
import { onMounted, ref } from 'vue'
import { getAddressList, setDefaultAddress } from '@/api/module/address'
onMounted(() => {
  sendAddressList()
})
const router = useRouter()
const isLoading = ref(false)
const addressList = ref([])
const onEdit = (item) => {
  router.push(`/address-add?id=${item.id}`)
}
const sendAddressList = async () => {
  const res = await getAddressList()
  res.info.forEach(item => {
    addressList.value.push({
      id: item.id,
      name: item.consignee,
      tel: item.phone,
      address: item.provinceName + item.cityName + item.districtName + item.detail,
      isDefault: item.isDefault === 1
    })
  })
}
const setDefaultHandler = async (val) => {
  isLoading.value = true
  const res = await setDefaultAddress(val)
  if (res.code === 1) {
    addressList.value = []
    await sendAddressList()
  }
  isLoading.value = false
}
</script>

<style scoped lang="scss">
.set-default{
  margin-top: 20px;
}
</style>
