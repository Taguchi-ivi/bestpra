<template>
<v-app-bar
    fixed
    :color="toolbarStyle.color"
    :elevation="toolbarStyle.elevation"
>
    <nuxt-link to="/about">
        <v-img width="50" src="/header-logo.png"></v-img>
    </nuxt-link>
    <v-toolbar-title class="ml-3 hidden-mobile-and-down">bestpra</v-toolbar-title>

    <v-spacer></v-spacer>

    <v-btn
        elevation="4"
        large
        outlined
        color="primary"
        to="/auth/signup" nuxt
    >
        会員登録
    </v-btn>
    <v-btn
        large
        text
        color="primary"
        class="ml-2"
        to="/auth/signin" nuxt
    >
        ログイン
    </v-btn>
</v-app-bar>
</template>

<script>

export default {
data ({ $config: $store }) {
    return {
        scrollY: 0,
    }
},
computed: {
    isScrollPoint () {
        // return this.scrollY > (500 - homeAppBarHeight)
        // return this.scrollY > (500 - this.$store.state.homeAppBarHeight)
        return this.scrollY > (500 - 56)
    },
    toolbarStyle () {
        let color = 'white'
        let elevation = 4

        if(this.$route.name === 'about') {
            if (!this.isScrollPoint) color = 'transparent';
            if (!this.isScrollPoint) elevation = 0;
        }
        return { color, elevation }
    }
},
// vue.new() => vueインスタンス
// マウントされた後 => vueの実行準備が完全に整った後
// vueファイルが読み込まれた後
mounted () {
    window.addEventListener('scroll', this.onScroll)
},
// vueインスタンスが破壊される前に実行される
// この画面が表示されなくなったら
beforeDestroy() {
    window.removeEventListener('scroll', this.onScroll)
},
methods: {
    onScroll () {
        this.scrollY = window.scrollY
    }
},
}
</script>