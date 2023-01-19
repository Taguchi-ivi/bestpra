<template>
    <v-app-bar
        color="primary"
        fixed
        elevate-on-scroll
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
export default {
}
</script>