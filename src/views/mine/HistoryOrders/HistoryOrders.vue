<template>
  <div class="history">
    <NavBar
      title="历史订单列表"
      left-arrow
      @click-left="$router.back()"
    />
    <List
      v-model:loading="loading"
      :finished="finished"
      finished-text="没有更多了"
      @load="onLoad"
    >
      <CellGroup
        inset
        class="history-wrapper"
        v-for="item in orderList"
        :key="item.id"
      >
        <Cell class="orders">
          <Icon
            name="orders-o"
            size="20px"
            @click="copyOrderId(item.number)"
          />
          <span class="orders-id">
            {{ item.number }}
          </span>
        </Cell>
        <Cell class="orders">
          <Icon
            name="manager-o"
            size="20px"
          />
          <span class="orders-id">
            {{ item.consignee }}
          </span>
        </Cell>
        <Cell class="orders">
          <Icon
            name="phone-o"
            size="20px"
          />
          <span class="orders-id">
            {{ item.phone }}
          </span>
        </Cell>
        <Cell class="orders">
          <Icon
            name="underway-o"
            size="20px"
          />
          <span class="orders-id">
            {{ item.checkoutTime }}
          </span>
        </Cell>
        <Cell class="orders">
          <Icon
            name="logistics"
            size="20px"
          />
          <span class="orders-id">
            {{ item.address }}
          </span>
        </Cell>
        <ul
          class="order-wrapper"
          v-for="list in item.orderDetailList"
          :key="list.id"
        >
          <li
            class="order-item"
          >
            <Image
              width="1.2rem"
              height="1.2rem"
              fit="cover"
              :src="BASE_IMGE_URL + list.image"
            />
            <div class="order-name">
              {{ list.name }}
            </div>
            <div class="order-num">
              <span class="number-logo">
                x
              </span>
              <span class="count">{{ list.number }}</span>
            </div>
          </li>
        </ul>
      </CellGroup>
    </List>
  </div>
</template>

<script name="HistoryOrders" setup>
import { NavBar, List, Icon, Toast, Image, CellGroup, Cell } from 'vant'
import { ref } from 'vue'
import useClipboard from 'vue-clipboard3'
import { sendGetHistoryOrders } from '@/api/module/user'
const BASE_IMGE_URL = import.meta.env.VITE_LOCAL_SERVE_IMGE_URL
const { toClipboard } = useClipboard()
const orderList = ref([])
const loading = ref(false)
const finished = ref(false)

const onLoad = () => {
  const page = orderList.value.length
  const pageSize = 10
  getHistoryOrders(page, pageSize)
}
const getHistoryOrders = async (page, pageSize) => {
  const res = await sendGetHistoryOrders({
    page,
    pageSize
  })
  loading.value = false
  if (res.code === 1) {
    orderList.value.push(...res.info.records)
    if (orderList.value.length >= res.info.total) {
      finished.value = true
    }
  } else {
    Toast(res.msg)
  }
}
const copyOrderId = async (id) => {
  try {
    await toClipboard(id)
    Toast('订单号复制成功')
  } catch (e) {
    Toast(e.message)
  }
}
</script>
<style scoped lang="scss">
.history-wrapper{
  margin-top: 20px;
  font-size: 14px;
  color: #737373;
  .orders{
    display: flex;
    padding-left: 20px;
    align-items: center;
    .orders-id{
      margin-left: 10px;
      margin-right: 10px;
    }
  }
  .order-wrapper{
    padding-left: 20px;
    .order-item{
      margin-bottom: 10px;
      display: flex;
      justify-content: flex-start;
      align-items: center;
      .van-image{
        overflow: hidden;
        border-radius: 10px;
      }
      .order-name{
        margin-left: 20px;
      }
      .order-num{
        margin-left: auto;
        margin-right: 20px;
        .number-logo{
          font-size: 12px;
        }
        .count{
          font-size: 14px;
        }
      }
    }
  }
}
</style>
