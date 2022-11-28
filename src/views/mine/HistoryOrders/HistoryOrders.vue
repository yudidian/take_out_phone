<template>
  <div class="history">
    <NavBar
      title="历史订单列表"
      left-arrow
      @click-left="$router.back()"
    />
    <List
      ref="list"
      v-model:loading="loading"
      :finished="finished"
      finished-text="没有更多了"
      @load="onLoad"
      class="list-wrapper"
    >
      <Empty
        image="https://fastly.jsdelivr.net/npm/@vant/assets/custom-empty-image.png"
        image-size="80"
        description="空空如也~"
        v-if="orderList.length === 0"
      />
      <CellGroup
        v-else
        inset
        class="history-wrapper"
        v-for="(item,index) in orderList"
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
              <div>
                <span class="number-logo">
                  x
                </span>
                <span class="count">{{ list.number }}</span>
              </div>
              <Button
                size="small"
                round
                icon="records"
                @click="$router.push({
                  name: 'WriteReview',
                  query: {
                    dishId: list.dishId,
                    setmealId: list.setmealId,
                    name: list.name,
                    image: list.image
                  }
                })"
              />
            </div>
          </li>
        </ul>
        <Cell class="bottom-btn">
          <Button
            style="margin-left: 20px"
            size="small"
            icon="delete-o"
            round
            @click="confirmReceipt(item.number, false, index)"
          >
            删除
          </Button>
        </Cell>
      </CellGroup>
    </List>
    <ToTop
      v-if="isShowScroll"
      @click="returnTop(list.$el)"
    />
  </div>
</template>

<script name="HistoryOrders" setup>
import { NavBar, List, Icon, Toast, Image, CellGroup, Cell, Empty, Button, Dialog, Notify } from 'vant'
import { onMounted, ref } from 'vue'
import useScroll from '@/hooks/useScroll'
import useClipboard from 'vue-clipboard3'
import { sendConfirmOrCancelOrders, sendGetHistoryOrders } from '@/api/module/user'
const BASE_IMGE_URL = import.meta.env.VITE_LOCAL_SERVE_IMGE_URL
const { toClipboard } = useClipboard()
const orderList = ref([])
const loading = ref(false)
const finished = ref(false)
const list = ref(null)
const { listenScroll, isShowScroll, returnTop } = useScroll()

onMounted(() => {
  listenScroll(list.value.$el)
})

const onLoad = () => {
  const pageSize = 10
  const page = (orderList.value.length / pageSize) + 1
  getHistoryOrders(page, pageSize)
}
const getHistoryOrders = async (page, pageSize) => {
  const res = await sendGetHistoryOrders({
    page,
    pageSize,
    state: 4
  })
  loading.value = false
  if (res.code === 1) {
    orderList.value.push(...res.info.records)
    // 列表长度和总数一样择停止查找
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
const confirmReceipt = (id, flag, index) => {
  Dialog.confirm({
    message: '是否删除订单，此操作不可逆！'
  })
    .then(async () => {
      const res = await sendConfirmOrCancelOrders({
        flag,
        ordersId: id
      })
      if (res.code === 1) {
        Toast.success('删除成功')
        orderList.value.splice(index, 1)
      } else {
        Notify({
          type: 'danger',
          message: res.msg
        })
      }
    })
}
</script>
<style scoped lang="scss">
.list-wrapper{
  width: 100%;
  height: calc(100vh - 46px);
  overflow-y: auto;
}
.history-wrapper {
  margin-top: 20px;
  font-size: 14px;
  color: #737373;
  .bottom-btn{
    :deep(>.van-cell__value){
      display: flex;
      justify-content: flex-end;
    }
  }
  .orders {
    display: flex;
    padding-left: 20px;
    align-items: center;

    .orders-id {
      margin-left: 10px;
      margin-right: 10px;
    }
  }

  .order-wrapper {
    padding-left: 20px;

    .order-item {
      margin-bottom: 10px;
      display: flex;
      justify-content: flex-start;
      align-items: center;

      .van-image {
        overflow: hidden;
        border-radius: 10px;
      }

      .order-name {
        margin-left: 20px;
      }

      .order-num {
        margin-left: auto;
        margin-right: 20px;
        display: flex;
        align-items: center;
        .number-logo {
          font-size: 12px;
        }
        .count {
          font-size: 14px;
          margin-right: 20px;
        }
      }
    }
  }
}
</style>
