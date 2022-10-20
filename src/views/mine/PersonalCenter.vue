<template>
  <div class="wrapper">
    <header>
      <p class="title">
        个人中心
      </p>
      <div class="user">
        <div class="img-wrapper">
          <img src="@/assets/image/headPage.png">
        </div>
        <span class="user-name">小喽啰</span>
        <img
          src="@/assets/image/women.png"
          class="user-icon"
        >
      </div>
    </header>
    <article>
      <section>
        <CellGroup inset>
          <Cell
            icon="guide-o"
            title="地址管理"
            is-link
            to="/address"
          />
          <Cell
            icon="records"
            title="历史订单"
            is-link
          />
        </CellGroup>
      </section>
      <section>
        <CellGroup inset>
          <Cell title="最新订单">
            <template #label>
              <div class="content">
                xxxxxxxxxxxxxx
              </div>
              <p class="description">
                共0件商品，实付0￥
              </p>
            </template>
          </Cell>
        </CellGroup>
      </section>
      <section>
        <CellGroup
          inset
          class="btn-exit"
        >
          <button class="exit-out">
            退出登录
          </button>
        </CellGroup>
      </section>
    </article>
  </div>
</template>

<script setup name="PersonalCenter">
import { CellGroup, Cell } from 'vant'
</script>

<style scoped lang="scss">
.wrapper{
  width: 100vw;
  height: 100vh;
  background-color: #F3F2F7;
  header{
    width: 375px;
    height: 164px;
    background-color: #FFC200;
    .title{
      padding-top: 40px;
      font-size: 18px;
      font-weight: 700;
      text-align: center;
    }
    .user{
      display: flex;
      align-items: center;
      padding-top: 20px;
      .img-wrapper{
        width: 58px;
        height: 58px;
        margin-left: 20px;
        border-radius: 50%;
        img{
          width: 58px;
          height: 58px;
        }
      }
      .user-name{
        padding: 0 10px;
        font-size: 16px;
      }
      .user-icon{
        width: 16px;
        height: 16px;
      }
    }
  }
  article{
    margin-top: 20px;
    section{
      margin-top: 10px;
      .content{
        height: 200px;
      }
      .description{
        text-align: right;
      }
      .btn-exit{
        display: flex;
        justify-content: center;
        height: 40px;
        .exit-out{
          background-color: #fff;
          border: none;
          font-size: 16px;
        }
      }
    }
  }
}

</style>
