<template>
  <v-app>
    <home-header />
    <v-main>
    <!-- <v-container> -->
      <Nuxt />
    <!-- </v-container> -->
    </v-main>
    <!-- <footer></footer> -->
    <home-footer />
  </v-app>
</template>
<!--
<script src="https://kit.fontawesome.com/14a540a64c.js" crossorigin="anonymous">
-->
<script>
import HomeHeader from '~/components/Home/HomeHeader'
import HomeFooter from '~/components/Home/HomeFooter'

export default {
  component: {
    HomeHeader,
    HomeFooter
  },
  data: () => ({
    // icons: [
    //   'mdi-home',
    //   'mdi-email',
    //   'mdi-calendar',
    //   'mdi-delete',
    // ],
    // items: [
    //   'default',
    //   'absolute',
    //   'fixed',
    // ],
    // padless: false,
    // variant: 'default',
    // drawer: false,
    // group: null,
  }),
  // vue.new() => vueインスタンス
  // マウントされた後 => vueの実行準備が完全に整った後
  // vueファイルが読み込まれた後
  mounted () {
  },
  // vueインスタンスが破壊される前に実行される
  // この画面が表示されなくなったら
  beforeDestroy() {
  },
  methods: {
  },

}
</script>
