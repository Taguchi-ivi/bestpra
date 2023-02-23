<template>
    <v-app-bar
        fixed
    >
        <slot name="navigation-toggle-button" />
        <!-- <nuxt-link to="/about"> -->
        <nuxt-link to="/home">
            <v-img width="50" src="/header-logo.png"></v-img>
        </nuxt-link>
        <v-toolbar-title class="ml-3 hidden-mobile-and-down">bestpra</v-toolbar-title>

        <v-spacer />

        <v-btn
            icon
            v-on="on"
        >
            <v-icon
                size="30"
            >
                mdi-bell-outline
            </v-icon>
        </v-btn>
        <AvatarSwitch
            headerFlg
            :size="33"
            :avatar="$auth.user.avatar"
            :id="Number($auth.user.id)"
        />
    </v-app-bar>
</template>

<script>

import AvatarSwitch from '~/components/Molecules/AvatarSwitch.vue'

export default {
    data() {
        return {
            on: false,
        }
    },
    components: {
        AvatarSwitch,
    },
}
</script>