<template>
    <v-app>
        <before-home-header />
        <v-main>
        <!-- <v-container> -->
            <AppToaster />
            <Nuxt />
            <PageTop />
        <!-- </v-container> -->
        </v-main>
        <before-home-footer />
    </v-app>
</template>
<!--
<script src="https://kit.fontawesome.com/14a540a64c.js" crossorigin="anonymous">
-->
<script>
import BeforeHomeHeader from '~/components/Organisms/BeforeLogin/BeforeHomeHeader.vue'
import BeforeHomeFooter from '~/components/Organisms/BeforeLogin/BeforeHomeFooter.vue'
import AppToaster from '~/components/Atom/App/AppToaster.vue'
import PageTop from '~/components/Atom/App/AppPageTop.vue'

export default {
    name: 'BeforeLogin',
    components: {
        // 'home-header': HomeHeader,
        // 'home-footer': HomeFooter
        BeforeHomeHeader,
        BeforeHomeFooter,
        AppToaster,
        PageTop
    },
    middleware: ['nuxt-server-init'],
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
