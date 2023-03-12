<template>
    <div>
        <div v-if="error">
            <ErrorCard
                title="存在しないページです"
                message="404 not found"
            />
        </div>
        <div v-if="!error">
            <!-- TODO 色どうする問題 -->
            <!-- class="grey lighten-4" -->
            <div
            >
                <v-row
                    no-gutters
                    class="pa-10"
                >
                    <v-col
                        cols="2"
                    >
                        <AvatarImg
                            :avatar-url="otherUser.avatar.url"
                        />
                        <p>{{ otherUser.nickname }}</p>
                    </v-col>
                    <v-col
                        cols="7"
                    >
                        <!-- {{ introduction }} -->
                        <div v-if="otherUser.introduction">
                            <!-- {{ introduction }} -->
                            {{ otherUser.introduction }}
                        </div>
                        <div v-else>
                            自己紹介はありません
                        </div>
                    </v-col>
                    <v-col
                        cols="3"
                    >
                        <div v-if="$my.isCurrentUser(otherUser.id)">
                            <v-menu
                                app
                                offset-x
                                offset-y
                                max-width="300"
                            >
                                <template
                                    #activator="{ on }"
                                >
                                    <v-btn
                                        icon
                                        v-on="on"
                                    >
                                        <v-icon size="20">
                                            mdi-cog-outline
                                        </v-icon>
                                    </v-btn>
                                </template>
                                <v-list
                                    dense
                                >
                                    <v-subheader>
                                        アカウント
                                    </v-subheader>
                                    <v-list-item
                                        to="/users/edit"
                                    >
                                        <v-list-item-icon
                                            class="mr-2"
                                        >
                                            <v-icon size="22">
                                                mdi-account-edit
                                            </v-icon>
                                        </v-list-item-icon>
                                        <v-list-item-title>
                                            編集する
                                        </v-list-item-title>
                                    </v-list-item>
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
                                                        mdi-account-remove
                                                    </v-icon>
                                                </v-list-item-icon>
                                                <v-list-item-title>
                                                    削除する
                                                </v-list-item-title>
                                            </v-list-item>
                                        </template>
                                        <v-card>
                                            <v-card-title class="text-h5">
                                                アカウント削除
                                            </v-card-title>
                                            <v-card-text>
                                                本当によろしいですか？<br />
                                                ※全てのデータが削除されます
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
                                                @click="accountDelete"
                                            >
                                                削除する
                                            </v-btn>
                                            </v-card-actions>
                                        </v-card>
                                    </v-dialog>
                                </v-list>
                            </v-menu>
                        </div>
                        <div v-else>
                            <v-btn
                                v-if="$my.isFollowed(otherUser.id)"
                                color="white--text red"
                                @click="unfollow"
                            >
                                フォロー解除
                            </v-btn>
                            <v-btn
                                v-else
                                color="primary"
                                @click="follow"
                            >
                                フォローする
                            </v-btn>
                        </div>
                    </v-col>
                </v-row>
            </div>
            <div
                style="width: 97%"
                class="mx-auto"
            >
                <v-divider />
            </div>
            <v-container
                fluid
                class="mt-5"
                >
                <v-row no-gutters>
                    <v-col
                        cols="3"
                    >
                        <v-list
                            rounded
                            color="transparent"
                            max-width="250"
                            class="toc-view"
                        >
                            <v-list-item-group
                                v-model="model"
                                mandatory
                                color="primary"
                            >
                                <v-list-item
                                    v-for="(item, i) in items"
                                    :key="i"
                                    :to="item.path" nuxt
                                >
                                    <v-list-item-icon>
                                        <v-icon>
                                            {{ item.icon }}
                                        </v-icon>
                                    </v-list-item-icon>
                                    <v-list-item-content>
                                        <v-list-item-title>
                                            {{ item.text }}
                                        </v-list-item-title>
                                    </v-list-item-content>
                                </v-list-item>
                            </v-list-item-group>
                        </v-list>
                    </v-col>
                    <v-col
                        cols="9"
                    >
                        <div v-if="$route.name === 'users-id'">
                            <div v-if="$my.isCurrentUser(otherUser.id)">
                                <p class="text-center">おかえりなさい</p>
                            </div>
                            <div v-else>
                                <p class="text-center">WellCome to {{ otherUser.nickname }}page</p>
                            </div>
                        </div>
                        <nuxt-child />
                    </v-col>
                </v-row>
            </v-container>
        </div>
    </div>
</template>

<script>

import { mapActions, mapGetters, mapMutations } from 'vuex'
import ErrorCard from '~/components/Molecules/ErrorCard.vue'
import AvatarImg from '~/components/Atom/App/AppAvatarImg.vue'

export default {
    name: 'UsersProfile',
    components: {
        ErrorCard,
        AvatarImg,
    },
    // middleware ({ params, redirect, route }) {
    //     // return redirect('/about')
    //     if(route.name === 'users-id') return redirect('/users/' + params.id + '/articles')
    // },
    async asyncData({$axios, $my, params, store, route}) {
        const res = await $axios.$get(`/api/v1/users/${params.id}`)
        console.log('res', res)
        if(res === 'bad_request') {
            store.dispatch('modules/toast/getToast', {
                        status: true,
                        msg: '存在しない練習メニュです',
                        color: 'error'
                    })
            return {
                error: true
            }
        }
        const path = route.path
        const pathArray = path.split('/')
        const routeName = pathArray[pathArray.length -1]
        if(routeName === 'notifications' && !$my.isCurrentUser(params.id)) {
            return {
                error: true,
            }
        }
        const items = [
                    {icon: 'mdi-note', text: '練習メニュー', path: `/users/${params.id}/articles`},
                    {icon: 'mdi-account-star', text: 'フォロー', path: `/users/${params.id}/following`},
                    {icon: 'mdi-account-star-outline', text: 'フォロワー', path: `/users/${params.id}/followers`},
                    {icon: 'mdi-heart', text: 'いいね', path: `/users/${params.id}/likes`},
                ]
        if($my.isCurrentUser(params.id)) {
            items.push(
                {icon: 'mdi-bell-outline', text: '通知', path: `/users/${params.id}/notifications`}
            )
            return {
                error: false,
                otherUser: res,
                items
            }
        } else {
            return {
                error: false,
                otherUser: res,
                items
            }
        }
    },
    data() {
        return {
            on: false,
            dialog: false,
            model: 0,
        }
    },
    // async fetch({ $axios, params, store}) {
    //     await $axios.$get(`api/v1/users/${params.id}`)
    //     // await $axios.$get(`api/v1/users/`)
    //         .then(res => {
    //             // console.log('resUser', res.user)
    //             store.dispatch('modules/error/getErrorStatus', false)
    //             store.dispatch('modules/user/getOtherUser', res.user)
    //             store.dispatch('modules/article/getWrittenArticles', res.articles)
    //         })
    //         .catch(err => {
    //             console.log('err', err)
    //             store.dispatch('modules/error/getErrorStatus', true)
    //             store.dispatch('modules/user/getOtherUser', null)
    //             store.dispatch('modules/toast/getToast', {
    //                 status: true,
    //                 msg: '存在しないユーザです',
    //                 color: 'error'
    //             })
    //         })
    // },
    // 算出プロパティ => 計算したデータを返す関数のこと
    // dateとほぼ一緒だが、複雑なデータなどはcomputedで使う
    computed: {
        ...mapGetters({
            currentUser: 'modules/user/getUser',
            followingUsers: 'modules/follow/getCurrentFollow',
            // writtenArticles: 'modules/article/getWrittenArticles',
            // otherUser: 'modules/user/getOtherUser',
            // error: 'modules/error/getErrorStatus',
        }),
    },
    methods: {
        ...mapActions({
            dispatchToast: 'modules/toast/getToast'
            // dispatchErr: 'modules/error/getErrorStatus',
            // dispatchOtherUser: 'modules/user/getOtherUser',
            // dispatchWrittenArticles: 'modules/article/getWrittenArticles',
        }),
        ...mapMutations({
            commitCreateFollow: 'modules/follow/setCreateCurrentFollow',
            commitDeleteFollow: 'modules/follow/setDeleteCurrentFollow',
        }),
        // Vuexのtoast.msgの値を変更する
        // resetOtherUser() {
        //     // return this.$store.dispatch('modules/user/getOtherUser', null)
        // },
        async accountDelete() {
            await this.$axios.$delete(`/api/v1/auth_token/${this.otherUser.id}`,{})
                .then(res => {
                    // console.log(res)
                    // this.$auth.login(res)
                    // const status = true
                    // const msg = '削除が完了しました'
                    // this.$store.dispatch('modules/toast/getToast', { status, msg })
                    this.$router.push('/about')
                    this.$auth.resetVuex()
                })
                .catch( err => {
                    console.log(err)
                    this.dispatchToast({
                        status: true,
                        msg: 'アカウト削除に失敗しました',
                        color: 'error'
                    })
                })
            this.dialog = false
        },
        async follow() {
            // await this.$axios.$post(`/api/v1/follow/${this.otherUser.id}`)
            await this.$axios.$post(`/api/v1/users/${this.$route.params.id}/relationships`)
                .then(res => {
                    // console.log(res)
                    this.commitCreateFollow(this.$route.params.id)
                })
                .catch( err => {
                    console.log(err)
                })
        },
        async unfollow() {
            await this.$axios.$post(`/api/v1/users/${this.$route.params.id}/relationships/unfollow`)
                .then(res => {
                    // console.log(res)
                    this.commitDeleteFollow(this.$route.params.id)
                })
                .catch( err => {
                    console.log(err)
                })
        },
        activeBell(name, userId) {
            let result = false
            if (name === '通知') {
                result = this.currentUser.id === userId
            } else {
                result = true
            }
            return result
        }
    },
    // idページからidページへ遷移(nuxt-link)するとエラーになるため、コメントアウト
    // async beforeDestroy () {
    //     // Vueインスタンスが破棄される直前にVuexのtoast.msgを削除する(無期限toastに対応)
    //     await this.resetOtherUser()
    // },
}
</script>