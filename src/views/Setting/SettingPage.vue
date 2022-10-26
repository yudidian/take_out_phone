<template>
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
  <Button class="exit-out">
    退出登录
  </Button>
</template>

<script setup name="SettingPage">
import { Cell, CellGroup, NavBar, Button } from 'vant'
</script>

<style scoped>

</style>
