<template>
  <section>
    <NavBar
      title="地址详情"
      left-text="返回"
      left-arrow
      @click-left="$router.back()"
    />
    <Empty
      image="https://fastly.jsdelivr.net/npm/@vant/assets/custom-empty-image.png"
      image-size="80"
      description="描述文字"
      v-if="addressList.length === 0"
    />
    <AddressList
      :switchable="false"
      :list="addressList"
      default-tag-text="默认"
      @add="$router.push('/address/add')"
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
  </section>
</template>
<script setup name="AddressPage">
import { AddressList, NavBar, Cell, Switch, Notify, Empty } from 'vant'
import { useRouter } from 'vue-router'
import { onMounted, ref } from 'vue'
import { getAddressList, setDefaultAddress } from '@/api/module/address'
onMounted(() => {
  sendAddressList()
})
const router = useRouter()
const addressList = ref([])
const onEdit = (item) => {
  router.push({
    name: 'AddressAdd',
    query: {
      id: item.id
    }
  })
}
const sendAddressList = async () => {
  const res = await getAddressList()
  if (res.code !== 1) {
    return Notify({
      type: 'danger',
      message: res.msg
    })
  }
  if (res.info === null) {
    return
  }
  res.info.forEach((item) => {
    addressList.value.push({
      id: item.id,
      name: item.consignee,
      tel: item.phone,
      address:
        item.provinceName + item.cityName + item.districtName + item.detail,
      isDefault: item.isDefault === 1
    })
  })
}
const setDefaultHandler = async (val) => {
  const res = await setDefaultAddress(val)
  if (res.code === 1) {
    addressList.value = []
    await sendAddressList()
  }
}
</script>

<style scoped lang="scss">
.set-default {
  margin-top: 20px;
}
</style>
