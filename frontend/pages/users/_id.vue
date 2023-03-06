<template>
    <div>
        <div v-if="error">
            <ErrorCard
                title="存在しないユーザです"
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
                        <!-- <div v-else>
                            <v-btn
                                v-if="!otherUser.isFollowed"
                                color="success"
                                @click="follow"
                            >
                                フォローする
                            </v-btn>
                            <v-btn
                                v-else
                                color="white--text red"
                                @click="unfollow"
                            >
                                フォロー解除
                            </v-btn>
                        </div> -->
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
                                color="primary"
                            >
                                <v-list-item
                                    v-for="item in items"
                                    :key="item.text"
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
                            {{ model }}
                        </v-list>
                    </v-col>
                    <v-col
                        cols="9"
                    >
                        <MainTitle
                            :title="model"
                        />
                        <div v-if="writtenArticles.length === 0">
                            <p>まだ投稿はありません</p>
                        </div>
                        <div v-else>
                            <v-row>
                                <v-col
                                    v-for="(article, index) in writtenArticles"
                                    :key="index"
                                    cols="4"
                                >
                                    <ArticleMain
                                        :article="article"
                                    />
                                </v-col>
                            </v-row>
                        </div>
                        <nuxt-child />
                    </v-col>
                </v-row>
            </v-container>
        </div>
    </div>
</template>

<script>

import { mapActions, mapGetters } from 'vuex'
// import { mapGetters } from 'vuex'
import ErrorCard from '~/components/Molecules/ErrorCard.vue'
import MainTitle from '~/components/Atom/App/AppMainTitle.vue'
import ArticleMain from '~/components/Molecules/ArticleMain.vue'
import AvatarImg from '~/components/Atom/App/AppAvatarImg.vue'

export default {
    name: 'UsersProfile',
    components: {
        MainTitle,
        ErrorCard,
        AvatarImg,
        ArticleMain,
    },
    data() {
        return {
            tabTitle: 'フォロワー',
            on: false,
            dialog: false,
            items: [
                {
                    icon: 'mdi-note',
                    text: '練習メニュー',
                },
                {
                    icon: 'mdi-account-star',
                    text: 'フォロー',
                },
                {
                    icon: 'mdi-account-star-outline',
                    text: 'フォロワー',
                },
                {
                    icon: 'mdi-heart',
                    text: 'いいね',
                },
            ],
            model: 'フォロー',
        }
    },
    // asyncDate => componentのデータを表示する前に実行されるメソッド
    // async => promiseを返す(promise => 非同期処理の結果を表示するオブジェクト)
    // await => promiseを返すまでJavaScriptを待機させる(async内のawaitが終わるまで次のステップに行かない)
    // async asyncData ({ $axios }) {
    //     let users = []
    //     await $axios.$get('/api/v1/users')
    //         .then(res => (users = res))
    //         .catch(err => (console.log(err)))
    //     return { users }
    // },
    async fetch({ $axios, params, store}) {
        await $axios.$get(`api/v1/users/${params.id}`)
        // await $axios.$get(`api/v1/users/`)
            .then(res => {
                // console.log('resUser', res.user)
                store.dispatch('modules/error/getErrorStatus', false)
                store.dispatch('modules/user/getOtherUser', res.user)
                store.dispatch('modules/article/getWrittenArticles', res.articles)
            })
            .catch(err => {
                console.log('err', err)
                store.dispatch('modules/error/getErrorStatus', true)
                store.dispatch('modules/user/getOtherUser', null)
                store.dispatch('modules/toast/getToast', {
                    status: true,
                    msg: '存在しないユーザです',
                    color: 'error'
                })
            })
    },
    // 算出プロパティ => 計算したデータを返す関数のこと
    // dateとほぼ一緒だが、複雑なデータなどはcomputedで使う
    computed: {
        ...mapGetters({
            currentUser: 'modules/user/getUser',
            otherUser: 'modules/user/getOtherUser',
            writtenArticles: 'modules/article/getWrittenArticles',
            error: 'modules/error/getErrorStatus',
        }),
    },
    methods: {
        ...mapActions({
            dispatchErr: 'modules/error/getErrorStatus',
            dispatchOtherUser: 'modules/user/getOtherUser',
            dispatchWrittenArticles: 'modules/article/getWrittenArticles',
            dispatchToast: 'modules/toast/getToast'
        }),
        // Vuexのtoast.msgの値を変更する
        resetOtherUser() {
            return this.$store.dispatch('modules/user/getOtherUser', null)
        },
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
                    this.$store.dispatch('modules/toast/getToast', {
                        status: true,
                        msg: 'アカウト削除に失敗しました',
                        color: 'error'
                    })
                })
            this.dialog = false
        }
    },
    // idページからidページへ遷移(nuxt-link)するとエラーになるため、コメントアウト
    // async beforeDestroy () {
    //     // Vueインスタンスが破棄される直前にVuexのtoast.msgを削除する(無期限toastに対応)
    //     await this.resetOtherUser()
    // },
}
</script>

<style lang="scss" scoped>
.toc-view {
    position: sticky;
    top: 5rem;
    max-height: 90vh;
    // overflow: scroll;
}
</style>