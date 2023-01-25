<template>
    <v-app-bar
        fixed
    >
        <!-- <v-app-bar-nav-icon></v-app-bar-nav-icon> -->
        <nuxt-link to="/about">
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
        <v-menu
            app
            offset-x
            offset-y
            max-width="200"
        >
            <template
                #activator="{ on }"
            >
                <v-btn
                    icon
                    v-on="on"
                >
                    <v-icon size="30">
                        mdi-account-circle
                    </v-icon>
                </v-btn>
            </template>
            <v-list
                dense
            >
                <v-subheader>
                    ログイン中のユーザー
                </v-subheader>

                <v-list-item>
                    <v-list-item-content>
                        <v-list-item-subtitle>
                        <!-- TODO -->
                        ユーザー名が表示されます
                        </v-list-item-subtitle>
                    </v-list-item-content>
                </v-list-item>

                <v-divider />

                <v-subheader>
                    アカウント
                </v-subheader>

                <template
                    v-for="(menu, i) in Menus"
                >
                    <v-divider
                        v-if="menu.divider"
                        :key="`menu-divider-${i}`"
                    />

                    <v-list-item
                        :key="`menu-list-${i}`"
                        :to="menu.path"
                    >
                        <v-list-item-icon
                            class="mr-2"
                        >
                            <v-icon
                                size="22"
                            >
                                {{ menu.icon }}
                            </v-icon>
                        </v-list-item-icon>
                        <v-list-item-title>
                            {{ menu.name }}
                            <!-- {{ $my.pageTitle(menu.name) }} -->
                        </v-list-item-title>
                    </v-list-item>
                </template>
            </v-list>
        </v-menu>
    </v-app-bar>
</template>

<script>

// import { mapMutations } from 'vuex'

export default {
    data ({ $config: $store }) {
        return {
            on: false,
            Menus: [
                { name: 'アカウント設定', icon: 'mdi-account-cog', divider: false, path: '/account/edit' },
                { name: 'パスワード変更', icon: 'mdi-lock-outline', divider: false, path: '/account/password'},
                { name: 'ログアウト', icon: 'mdi-logout-variant', divider: true, path: '/logout' }
            ]
        }
    },
}
</script>