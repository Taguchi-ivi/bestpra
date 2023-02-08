<template>
    <v-app>
        <logged-in-home-header>
            <template #navigation-toggle-button>
                <v-app-bar-nav-icon
                    @click="drawer = !drawer"
                >
                </v-app-bar-nav-icon>
            </template>
        </logged-in-home-header>
        <navigation-drawer
            :drawer.sync="drawer"
        />
        <v-main>
        <!-- <v-container> -->
        <margin-top />
        <Nuxt />
        <margin-bottom />
        <!-- </v-container> -->
        </v-main>
        <logged-in-home-footer />
    </v-app>
</template>
<!--
<script src="https://kit.fontawesome.com/14a540a64c.js" crossorigin="anonymous">
-->
<script>
import LoggedInHomeHeader from '~/components/Organisms/LoggedIn/LoggedInHomeHeader.vue'
import LoggedInHomeFooter from '~/components/Organisms/LoggedIn/LoggedInHomeFooter.vue'
import NavigationDrawer from '~/components/Organisms/Application/NavigationDrawer.vue'
import marginTop from '~/components/Atom/margin/marginTop.vue'
import marginBottom from '~/components/Atom/margin/marginBottom.vue'

export default {
    components: {
        LoggedInHomeHeader,
        LoggedInHomeFooter,
        NavigationDrawer,
        marginTop,
        marginBottom
    },
    data() {
        return {
            drawer: null
        }
    },
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
