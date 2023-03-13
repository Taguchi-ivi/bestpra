<template>
    <!-- TODO  -->
    <!-- avatarが存在しない場合はiconを -->
    <!-- flgがtrueなら押下時に下に値を表示 -->
    <!-- trueではない場合はシンプルにlinkを作成してその人のprofileページへ -->
    <!-- <h1>avatarのcomponentを作成したい</h1> -->
    <div>
        <div v-if="headerFlg">
            <v-menu
                app
                offset-x
                offset-y
                width="200"
                class="pa-3 z-500"
            >
                <template
                    #activator="{ on }"
                >
                    <v-btn
                        icon
                        v-on="on"
                    >
                        <!-- <v-icon size="30">
                            mdi-account-circle
                        </v-icon> -->
                        <AvatarImg
                            :size="size"
                            :avatar-url="avatarUrl"
                        />
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
                            <v-list-item :to="`/users/${id}/articles`">
                                <v-list-item-subtitle>
                                    {{ $auth.user.nickname }}
                                </v-list-item-subtitle>
                            </v-list-item>
                        </v-list-item-content>
                    </v-list-item>

                    <!-- <v-divider /> -->
                    <div
                        v-for="(menu, i) in Menus"
                        :key="`menu-divider-${i}`"
                    >
                        <template>
                            <v-divider
                                v-if="menu.divider"
                            />
                            <v-subheader v-if="menu.title">
                                {{ menu.title }}
                            </v-subheader>
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
        </div>
        <div v-else>
            <div v-if="id !== 0">
                <nuxt-link
                    :to="`/users/${id}/articles`"
                >
                    <AvatarImg
                        :size="Number(size)"
                        :avatar-url="avatarUrl"
                    />
                </nuxt-link>
            </div>
            <div v-else>
                <AvatarImg
                    :size="Number(size)"
                    :avatar-url="avatarUrl"
                />
            </div>
        </div>
    </div>
</template>

<script>
import { mapActions } from 'vuex'
import AvatarImg from '~/components/Atom/App/AppAvatarImg.vue'

export default {
    components: {
        AvatarImg,
    },
    props: {
        // sizeの調整はAvatar-img-componentsも修正する
        size: {
            type: Number,
            default: 40
        },
        headerFlg: {
            type: Boolean,
            default: false
        },
        avatarUrl: {
            type: String,
            default: ''
        },
        id: {
            type: Number,
            default: 0
        },
    },
    data() {
        return {
            on: false,
            dialog: false,
            Menus: [
                { title: 'アカウント', name: '編集', icon: 'mdi-account-cog', divider: true, path: '/users/edit' },
                { title: '探す', name: '検索', icon: 'mdi-magnify', divider: true, path: '/search' },
                { title: '', name: 'ラベル', icon: 'mdi-label', divider: false, path: '/levels/0' },
                { title: '', name: 'タグ', icon: 'mdi-tag-multiple', divider: false, path: '/tags/0' },
            ],
        }
    },
    methods: {
        ...mapActions({
            logout: 'modules/user/logout',
        }),
        async appLogout() {
            // const userInfo = this.$store.getters['modules/user/getUser']
            // console.log(userInfo)
            // this.logout(userInfo)
            // this.$auth.login(res)
            await this.$auth.logout()
            this.$router.push('/about')
        }
    },
}

</script>