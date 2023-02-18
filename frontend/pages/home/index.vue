<template>
    <v-container>
        <v-row>
            <v-col
                cols="3"
                class="toc-view"
            >
                <v-list
                    rounded
                    color="transparent"
                    max-width="250"
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
                <div v-if="loading">
                    <TheLoading />
                </div>
                <div v-else>

                    <MainTitle
                        title="練習メニュー"
                    />
                    <CardArticle />
                    <MainTitle
                        title="タグ"
                    />
                    <CardTag />
                    <MainTitle
                        title="ユーザー"
                    />
                    <CardUser />
                </div>
            </v-col>
        </v-row>
    </v-container>
</template>


<script>
import MainTitle from '~/components/Atom/App/AppMainTitle.vue'
import CardArticle from '~/components/Organisms/Card/CardArticle.vue'
import CardTag from '~/components/Organisms/Card/CardTag.vue'
import CardUser from '~/components/Organisms/Card/CardUser.vue'
import TheLoading from '~/components/Organisms/Application/TheLoading.vue'

export default {
    // middleware: 'get-article-current',
    // middleware: ['before-login-user'],
    components: {
        MainTitle,
        CardArticle,
        CardTag,
        CardUser,
        TheLoading
    },
    layout: 'home',
    middleware: ['authentication','get-project-list'],
    data() {
        return {
            users: {},
            loading: true,
            items: [
                {
                    icon: 'mdi-note',
                    text: '練習メニュー',
                },
                {
                    icon: 'mdi-book-open-blank-variant',
                    text: '練習ノート',
                },
                {
                    icon: 'mdi-account-multiple',
                    text: 'ユーザー',
                },
            ],
            model: 1,
        }
    },
    created() {
        this.loading = false
    },
    methods: {
        testBtn() {
            // const user = {
            //     nickname: this.params.user.name,
            //     email: this.params.user.email,
            //     uid: 'aaaaaaaaaa'
            // }
            // this.$axios.post('/api/v1/users', { user })
            //     .then(response => {
            //             console.log(response)
            //         })
            // this.$axios.get('/api/v1/users')
            //     .then(response => {
            //         this.users = response.data
            //     })
        },
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