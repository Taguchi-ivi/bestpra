<template>
        <!-- elevate-on-scroll -->
        <!-- color="primary" -->
        <!-- :height="homeAppBarHeight" -->
    <v-app-bar
        fixed
        :color="toolbarStyle.color"
        :elevation="toolbarStyle.elevation"
    >
        <!-- <v-app-bar-nav-icon></v-app-bar-nav-icon> -->
        <nuxt-link to="/about">
            <v-img width="50" src="/header-logo.png"></v-img>
        </nuxt-link>
        <v-toolbar-title class="ml-3">bestpra</v-toolbar-title>

        <v-spacer></v-spacer>

        <!-- 検索 -->
        <!-- <div class="my-auto">
            <v-text-field
            label="Filled"
            placeholder="Dense & Rounded"
            filled
            rounded
            dense
            ></v-text-field>
        </div>
        <v-btn icon>
            <v-icon>mdi-magnify</v-icon>
        </v-btn> -->
        <!-- <div class="sy my-auto">{{ scrollY }}</div> -->
        <!-- <div class="sy my-auto">{{ isScrollPoint }}</div> -->
        <v-btn
            elevation="4"
            large
            outlined
            color="indigo"
            to="/auth/signup" nuxt
        >
            ログイン
        </v-btn>
        <!-- if profile -->

        <!-- <v-btn icon>
            <v-icon>mdi-heart</v-icon>
        </v-btn> -->

        <v-btn icon>
            <v-icon>mdi-dots-vertical</v-icon>
        </v-btn>
    </v-app-bar>
</template>

<script>

// import { mapMutations } from 'vuex'

export default {
    data ({ $config: $store }) {
        return {
            scrollY: 0,
            // homeAppBarHeight: this.$store.state.homeAppBarHeight
        }
    },
    computed: {
        isScrollPoint () {
            // return this.scrollY > (500 - homeAppBarHeight)
            // return this.scrollY > (500 - this.$store.state.homeAppBarHeight)
            return this.scrollY > (500 - 56)
        },
        toolbarStyle () {
            const color = this.isScrollPoint ? 'white' : 'transparent'
            const elevation = this.isScrollPoint ? 4 : 0
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