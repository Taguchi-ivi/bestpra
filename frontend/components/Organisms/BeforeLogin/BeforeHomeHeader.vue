<template>
    <v-app-bar
        fixed
        :color="toolbarStyle.color"
        :elevation="toolbarStyle.elevation"
        class="z-500"
    >
        <nuxt-link to="/about">
            <v-img
                :width="$vuetify.breakpoint.xs ? 35 : 50"
                :src="headerLogo"
            >
        </v-img>
        </nuxt-link>
        <v-toolbar-title class="ml-3 hidden-mobile-and-down">bestpra</v-toolbar-title>

        <v-spacer></v-spacer>

        <div
            class="mr-2"
        >
            <v-btn
                elevation="4"
                outlined
                :small="$vuetify.breakpoint.xs ? true : false"
                color="primary"
                to="/auth/signup" nuxt
            >
                会員登録
            </v-btn>
        </div>
        <div>
            <v-btn
                text
                color="primary"
                :small="$vuetify.breakpoint.xs ? true : false"
                to="/auth/signin" nuxt
            >
                ログイン
            </v-btn>
        </div>
    </v-app-bar>
</template>

<script>
import headerLogo from '~/assets/img/header/header-logo.png'

export default {
    data () {
        return {
            headerLogo,
            scrollY: 0,
        }
    },
    computed: {
        isScrollPoint () {
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
    mounted () {
        window.addEventListener('scroll', this.onScroll)
    },
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