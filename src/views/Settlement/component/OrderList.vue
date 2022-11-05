<template>
  <CellGroup
    inset
    class="cell-item"
  >
    <Cell class="address-wrapper">
      <header>
        <span class="address-title">地址信息</span>
      </header>
      <div class="address-info">
        <div class="left">
          <div class="user-info">
            <span class="user-name">
              {{ userAddress.name }}
            </span>
            <span class="user-phone">
              {{ userAddress.tel }}
            </span>
          </div>
          <div class="address-detail">
            {{ userAddress.address }}
          </div>
        </div>
        <div class="right">
          <Icon
            name="arrow"
            @click="$router.push('/address/choose')"
          />
        </div>
      </div>
    </Cell>
  </CellGroup>
  <CellGroup
    inset
    class="cell-item"
  >
    <Cell
      :title="sendInfo.payMethod === 1 ? '微信支付' : '支付宝支付'"
      is-link
      @click="showSheet = true"
    />
  </CellGroup>
  <CellGroup
    inset
    class="cell-item"
  >
    <Cell
      title="购物车列表"
    />
    <Cell class="cart-list">
      <CartList @get-price="$emit('getPrice', $event)" />
    </Cell>
  </CellGroup>
  <CellGroup inset>
    <Field
      v-model="sendInfo.remark"
      rows="2"
      autosize
      label="备注"
      type="textarea"
      maxlength="50"
      placeholder="请输入备注"
      show-word-limit
    />
  </CellGroup>
  <ActionSheet
    v-model:show="showSheet"
    :actions="actions"
    cancel-text="取消"
    close-on-click-action
    @select="selectHandler"
  />
</template>

<script setup name="OrderList">
import { CellGroup, Cell, Icon, ActionSheet, Field, Dialog } from 'vant'
import { getDefaultAddress } from '@/api/module/address'
import { onMounted, ref, getCurrentInstance, onBeforeUnmount, reactive } from 'vue'
import { useRouter } from 'vue-router'
const { proxy } = getCurrentInstance()
defineEmits(['getPrice'])
const router = useRouter()
// 支付方式
const actions = [
  { name: '微信', pay: 1 },
  { name: '支付宝', pay: 2 }
]
// 要发送给服务器的数据
const sendInfo = reactive({
  addressBookId: '',
  remark: '', // 备注
  payMethod: 1 // 1 微信 2 支付宝
})
// 用户地址信息
const userAddress = ref({})
// 支付方式面板
const showSheet = ref(false)
onMounted(() => {
  getUserDefaultAddress()
  // 注册全局事件用于接收用户选择信息
  proxy.$bus.on('changeUserAddress', (val) => {
    userAddress.value = { ...val }
    sendInfo.addressBookId = val.id
  })
})
// 销毁注册的事件
onBeforeUnmount(() => {
  proxy.$bus.off('changeUserAddress')
})
// 选择支付方式
const selectHandler = (item) => {
  sendInfo.payMethod = item.pay
  showSheet.value = false
}
// 获取默认地址
const getUserDefaultAddress = async () => {
  const res = await getDefaultAddress()
  if (res.code === 1) {
    if (res.info === null) {
      Dialog.alert({
        message: '还没有设置收货地址哦，快去设置吧~'
      }).then(() => {
        return router.push('/address')
      })
    }
    sendInfo.addressBookId = res.info.id
    userAddress.value = {
      address:
        res.info.provinceName +
        res.info.cityName +
        res.info.districtName +
        res.info.detail,
      name: res.info.consignee,
      tel: res.info.phone,
      id: res.info.id
    }
  }
}
defineExpose({
  sendInfo
})
</script>

<style scoped lang="scss">
@import "@/style/util.scss";
.address-wrapper {
  height: auto;
  header {
    .address-title {
      padding: 6px;
      font-size: 14px;
      border-bottom: 3px solid $main-color;
    }
  }
  .address-info {
    width: 100%;
    margin-top: 10px;
    display: flex;
    align-items: center;
    .left {
      width: 90%;
      padding-left: 10px;
      .user-info {
        display: flex;
        height: 30px;
        align-items: center;
        .user-name {
          font-size: 24px;
          font-weight: 400;
          margin-right: 20px;
        }
        .user-phone {
          font-size: 20px;
          font-weight: 400;
        }
      }
      .address-detail {
        word-break: break-word;
        font-size: 12px;
      }
    }
    .right {
      font-size: 20px;
    }
  }
}
.cart-list {
  width: 100%;
  height: 260px;
  :deep(>.van-cell__value){
    overflow-y: auto;
    height: auto;
    .cart-wrapper {
      overflow: hidden;
      height: auto;
    }
  }
}
.cell-item {
  margin-bottom: 4px;
}
</style>
