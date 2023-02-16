<template>
    <v-app-bar
        fixed
    >
        <slot name="navigation-toggle-button" />
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
                            {{ $auth.user.nickname }}
                        </v-list-item-subtitle>
                    </v-list-item-content>
                </v-list-item>

                <v-divider />

                <v-subheader>
                    アカウント
                </v-subheader>
                <div
                    v-for="(menu, i) in Menus"
                    :key="`menu-divider-${i}`"
                >
                    <template>
                        <v-divider
                            v-if="menu.divider"
                        />
                        <v-list-item
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
                </div>
                <v-divider />
                <v-dialog
                    v-model="dialog"
                    max-width="290"
                >
                    <template #activator="{ on, attrs }">
                        <v-list-item
                            v-bind="attrs"
                            v-on="on"
                        >
                            <v-list-item-icon
                                class="mr-2"
                            >
                                <v-icon
                                    size="22"
                                >
                                    mdi-logout-variant
                                </v-icon>
                            </v-list-item-icon>
                            <v-list-item-title>
                                ログアウト
                            </v-list-item-title>
                        </v-list-item>
                    </template>
                    <v-card>
                        <v-card-title class="text-h5">
                            本当に<br />ログアウトしますか？
                        </v-card-title>
                        <v-card-text>
                            ログアウトした場合<br />再度ログインが必要となります。
                        </v-card-text>
                        <v-card-actions>
                        <v-spacer />
                        <!-- color="green darken-1" -->
                        <v-btn
                            color="blue"
                            text
                            @click="dialog = false"
                        >
                            キャンセル
                        </v-btn>
                        <v-btn
                            color="red"
                            text
                            @click="appLogout"
                        >
                            ログアウト
                        </v-btn>
                        </v-card-actions>
                    </v-card>
                </v-dialog>
            </v-list>
        </v-menu>
    </v-app-bar>
</template>

<script>

import { mapActions } from 'vuex'

export default {
    data ({ $config: $store }) {
        return {
            on: false,
            dialog: false,
            Menus: [
                { name: 'アカウント設定', icon: 'mdi-account-cog', divider: false, path: '/users/edit' },
                { name: 'help', icon: 'mdi-chat-question', divider: false, path: '/help'},
            ]
        }
    },
    methods: {
        ...mapActions({
            logout: 'modules/user/logout',
        }),
        appLogout() {
            const userInfo = this.$store.getters['modules/user/getUser']
            // console.log(userInfo)
            this.logout(userInfo)
            this.$router.push('/about')
        }
    },
}
</script>