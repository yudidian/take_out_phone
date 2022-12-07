<template>
  <section class="setting-page">
    <NavBar
      title="用户设置"
      left-arrow
      @click-left="$router.back()"
    />
    <CellGroup inset>
      <Cell
        icon="shop-collect-o"
        title="用户信息编辑"
        is-link
        to="/user/setting"
      />
      <Cell
        icon="guide-o"
        title="地址管理"
        is-link
        to="/address"
      />
      <Cell
        icon="guide-o"
        title="联系客服"
        is-link
        to="/customerService"
      />
    </CellGroup>
    <Button
      class="exit-out"
      type="danger"
      round
      @click="exitOut"
    >
      退出登录
    </Button>
  </section>
</template>

<script setup name="SettingPage">
import { Cell, CellGroup, NavBar, Button, Dialog } from 'vant'
import { useRouter } from 'vue-router'
const router = useRouter()
const exitOut = () => {
  Dialog({
    showCancelButton: true,
    message:
        '是否要退出？'
  })
    .then(() => {
      router.replace('/login')
      localStorage.clear()
    })
    .catch(() => {
      // on cancel
    })
}
</script>

<style scoped lang="scss">
.setting-page{
  position: relative;
  .exit-out{
    width: 200px;
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
    top: 220px;
  }
}

</style>
