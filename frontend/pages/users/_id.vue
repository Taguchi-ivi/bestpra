<template>
    <div>
        <div
            class="grey lighten-1"
        >
            <v-row
                no-gutters
                class="pa-10 mx-auto"
            >
                <v-col
                    cols="2"
                >
                    <!-- <v-avatar>
                        <v-icon>
                            mdi-account-circle
                        </v-icon>
                    </v-avatar> -->
                    <AvatarImg
                        :avatar="otherUser.avatar.url"
                    />
                    <!-- <p>{{ name }}</p> -->
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
                    <div v-if="otherUser.current_user">
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
                                <!-- <v-divider /> -->
                                <!-- <v-list-item>
                                    <v-list-item-icon
                                        class="mr-2"
                                    >
                                        <v-icon size="22">
                                            mdi-account-remove
                                        </v-icon>
                                    </v-list-item-icon>
                                    <v-list-item-title>
                                        削除する
                                    </v-list-item-title>
                                </v-list-item> -->
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
        <v-container
            class="mt-5"
        >
            <!-- <table v-if="users.length">
                <thead>
                    <tr>
                    <th>id</th>
                    <th>nickname</th>
                    <th>email</th>
                    <th>created_at</th>
                    </tr>
                </thead>
                <tbody>
                    <tr
                    v-for="(user, i) in users"
                    :key="`user-${i}`"
                    >
                    <td>{{ user.id }}</td>
                    <td>{{ user.nickname }}</td>
                    <td>{{ user.email }}</td>
                    <td>{{ dateFormat(user.created_at) }}</td>
                    </tr>
                </tbody>
            </table>

            <div v-else>
            ユーザーが取得できませんでした
            </div> -->
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
                            color="indigo"
                        >
                            <v-list-item
                                v-for="(item, i) in items"
                                :key="i"
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
                    <MainTitle
                        :title="tabTitle"
                    />
                    <CardArticle />
                </v-col>
            </v-row>
        </v-container>
    </div>
</template>

<script>

// import { mapActions, mapGetters } from 'vuex'
import { mapGetters } from 'vuex'
import soccerBallImg from '~/assets/img/ball/soccer-ball.png'
import MainTitle from '~/components/Atom/App/AppMainTitle.vue'
import CardArticle from '~/components/Organisms/Card/CardArticle.vue'
import AvatarImg from '~/components/Atom/App/AppAvatarImg.vue'

export default {
    name: 'UsersProfile',
    components: {
        MainTitle,
        CardArticle,
        AvatarImg,
    },
    data() {
        return {
            tabTitle: 'フォロワー',
            soccerBallImg,
            on: false,
            dialog: false,
            // introduction: 'testtesttesttesttesttesttesttesttesttesttesttesttesttest',
            // name: 'meron',
            items: [
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
                {
                    icon: 'mdi-note',
                    text: '練習メニュー',
                },
                {
                    icon: 'mdi-book-open-blank-variant',
                    text: '練習ノート',
                },
            ],
            model: 1,
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
    async fetch({ $axios, params, store }) {
        await $axios.$get(`api/v1/users/${params.id}`)
        // await $axios.$get(`api/v1/users/`)
            .then(res => {
                console.log(res)
                store.dispatch('modules/user/getOtherUser', res)
            })
            .catch(err => {
                console.log(err)
                const status = true
                const msg = '存在しないユーザです'
                const color = 'error'
                store.dispatch('modules/toast/getToast', { status, msg, color })
            })
    },
    // 算出プロパティ => 計算したデータを返す関数のこと
    // dateとほぼ一緒だが、複雑なデータなどはcomputedで使う
    computed: {
        ...mapGetters({
            currentUser: 'modules/user/getUser',
            otherUser: 'modules/user/getOtherUser'
        }),
        dateFormat() {
            return (date) => {
                const dateTimeFormat = new Intl.DateTimeFormat(
                    'ja', { dateStyle: 'medium', timeStyle: 'short'}
                )
                return dateTimeFormat.format(new Date(date))
            }
        }
    },
    methods: {
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
                    this.$auth.resetVuex()
                    this.$router.push('/about')
                })
                .catch( err => {
                    console.log(err)
                    const status = true
                    const msg = 'アカウト削除に失敗しました'
                    const color = 'error'
                    this.$store.dispatch('modules/toast/getToast', { status, msg, color })
                })
            this.dialog = false
        }
    },
    beforeDestroy () {
        // Vueインスタンスが破棄される直前にVuexのtoast.msgを削除する(無期限toastに対応)
        this.resetOtherUser()
    },
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