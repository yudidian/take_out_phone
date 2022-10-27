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
    </CellGroup>
    <Button
      class="exit-out"
      type="danger"
      round
    >
      退出登录
    </Button>
  </section>
</template>

<script setup name="SettingPage">
import { Cell, CellGroup, NavBar, Button } from 'vant'
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
