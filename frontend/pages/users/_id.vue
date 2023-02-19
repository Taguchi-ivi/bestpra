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
                    <v-avatar color="indigo">
                        <v-icon dark>
                            mdi-account-circle
                        </v-icon>
                    </v-avatar>
                    <p>{{ name }}</p>
                </v-col>
                <v-col
                    cols="7"
                >
                    {{ introduction }}
                </v-col>
                <v-col
                    cols="3"
                >
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
                            <v-list-item>
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
                            </v-list-item>
                        </v-list>
                    </v-menu>
                </v-col>
            </v-row>
        </div>
        <v-container
            class="mt-5"
        >
            <table v-if="users.length">
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
            </div>
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

import soccerBallImg from '~/assets/img/ball/soccer-ball.png'
import MainTitle from '~/components/Atom/App/AppMainTitle.vue'
import CardArticle from '~/components/Organisms/Card/CardArticle.vue'

export default {
    components: {
        MainTitle,
        CardArticle
    },
    data() {
        return {
            tabTitle: 'フォロワー',
            soccerBallImg,
            on: false,
            introduction: 'testtesttesttesttesttesttesttesttesttesttesttesttesttest',
            name: 'meron',
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
    async asyncData ({ $axios }) {
        let users = []
        await $axios.$get('/api/v1/users')
            .then(res => (users = res))
            .catch(err => (console.log(err)))
        return { users }
    },
    // 算出プロパティ => 計算したデータを返す関数のこと
    // dateとほぼ一緒だが、複雑なデータなどはcomputedで使う
    computed: {
        dateFormat() {
            return (date) => {
                const dateTimeFormat = new Intl.DateTimeFormat(
                    'ja', { dateStyle: 'medium', timeStyle: 'short'}
                )
                return dateTimeFormat.format(new Date(date))
            }
        }
    }
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