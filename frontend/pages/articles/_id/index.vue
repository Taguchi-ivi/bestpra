<template>
    <v-container>
        <v-card
            width="100%"
            class="mx-auto pa-5"
            elevation="2"
        >
            <NoImg />
            <v-card
                width="80%"
                flat
                color="transparent"
                class="mx-auto"
            >
                <div class="d-flex justify-end">
                    <v-btn
                        icon
                    >
                        <v-icon
                            size="30"
                        >
                            mdi-heart-outline
                        </v-icon>
                    </v-btn>
                    <div v-if="currentUser.id === currentArticleData.user_id">
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
                                    <v-icon size="25">
                                        mdi-dots-vertical
                                    </v-icon>
                                </v-btn>
                            </template>
                            <v-list
                                dense
                            >
                                <v-subheader>
                                    練習メニュー
                                </v-subheader>
                                <v-list-item
                                    :to="`/articles/${currentArticleData.user.id}/edit`"
                                >
                                    <v-list-item-icon
                                        class="mr-2"
                                    >
                                        <v-icon size="22">
                                            mdi-pencil
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
                                            mdi-trash-can-outline
                                        </v-icon>
                                    </v-list-item-icon>
                                    <v-list-item-title>
                                        削除する
                                    </v-list-item-title>
                                </v-list-item>
                            </v-list>
                        </v-menu>
                    </div>
                </div>
                <!-- <h1 class="mt-5 text-center">タイトルを表示</h1> -->
                <h1 class="mt-5 text-center">{{ currentArticleData.title }}</h1>
                <UserCardTag
                    :avatarUrl="currentArticleData.user.avatar.url"
                    :userId="currentArticleData.user_id"
                    :level="currentArticleData.level_name"
                />
                <!-- <p class="ml-2">this.name</p> -->
                <!-- <p class="ml-2">{{ currentArticle.user.nickname }}</p> -->
                <p class="ml-2">{{ currentArticleData.user.nickname }}</p>
                <div
                    class="d-flex mt-5"
                >
                    <p>作成日:{{ $my.dataFormat(currentArticleData.created_at) }}</p>
                    <p class="ml-3">更新日:{{ $my.dataFormat(currentArticleData.updated_at) }}</p>
                </div>
                <!-- <client-only>
                    <Ckeditor v-model="text" />
                </client-only> -->
                <div
                    class="mt-5"
                >
                    <!-- {{ text }} -->
                    <!-- {{ currentArticleData }}
                    {{ currentArticleData.user.id }} -->
                    {{ currentArticleData.content }}
                </div>
            </v-card>
        </v-card>
        <v-card class="mt-8 pa-3">
            <MainTitle title="Comment" />
                <div v-if="comment">
                    <CardComment />
                </div>
                <div v-else>
                    <p class="text-center">コメントを投稿しよう!!</p>
                </div>
                <v-card
                    flat
                    color="transparent"
                    width="80%"
                    class="ml-auto"
                >
                    <v-textarea
                        outlined
                        label="Comment"
                        color="indigo"
                        class="mt-5"
                    >
                    </v-textarea>
                    <div class="text-right">
                        <v-btn
                            color=indigo
                            dark
                        >
                            コメント
                        </v-btn>
                    </div>
                </v-card>
        </v-card>
    </v-container>
</template>

<script>

// import { mapActions, mapGetters } from 'vuex'
import { mapGetters } from 'vuex'
import NoImg from '~/components/Atom/App/AppNoImg.vue'
import UserCardTag from '~/components/Molecules/UserCardTag.vue'
import MainTitle from '~/components/Atom/App/AppMainTitle.vue'
import CardComment from '~/components/Organisms/Card/CardComment.vue'

export default {
    // components: {
    //     Ckeditor,
    // },
    components: {
        NoImg,
        UserCardTag,
        MainTitle,
        CardComment,
    },
    data() {
        return {
            title: '',
            image: '',
            text: 'hello world',
            comment: 'a',
        }
    },
    computed: {
        ...mapGetters({
            currentArticleData: 'modules/article/getCurrentArticleData',
            currentUser: 'modules/user/getUser',
        })
    },
    methods: {
        resetArticle() {
            return this.$store.dispatch('modules/article/getCurrentArticleData', null)
        }
    },
    async fetch({ $axios, params, store }) {
        await $axios.$get(`api/v1/articles/${params.id}`)
        // await $axios.$get(`api/v1/users/`)
            .then(res => {
                console.log(res)
                store.dispatch('modules/article/getCurrentArticleData', res)
            })
            .catch(err => {
                console.log(err)
                store.dispatch('modules/toast/getToast', {
                    status: true,
                    msg: '存在しない記事です',
                    color: 'error'
                })
            })
    },
    beforeDestroy () {
        // Vueインスタンスが破棄される直前にVuexのtoast.msgを削除する(無期限toastに対応)
        this.resetArticle()
    },
};
</script>