<template>
    <div>
        <div v-if="error">
            <ErrorCard
                title="存在しない練習メニュです"
                message="404 not found"
            />
        </div>
        <div v-else>
            <v-container>
                <v-card
                    width="100%"
                    class="mx-auto pa-5"
                    elevation="2"
                >
                    <AppImg
                        :img-url="currentArticleData.image.url"
                    />
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
                                            :to="`/articles/${currentArticleData.id}/edit`"
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
                                                            mdi-trash-can-outline
                                                        </v-icon>
                                                    </v-list-item-icon>
                                                    <v-list-item-title>
                                                        削除する
                                                    </v-list-item-title>
                                                </v-list-item>
                                            </template>
                                            <v-card>
                                                <v-card-title class="text-h5">
                                                    練習メニュを削除
                                                </v-card-title>
                                                <v-card-text>
                                                    本当によろしいですか？<br />
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
                                                    @click="articleDelete"
                                                >
                                                    削除する
                                                </v-btn>
                                                </v-card-actions>
                                            </v-card>
                                        </v-dialog>
                                    </v-list>
                                </v-menu>
                            </div>
                        </div>
                        <!-- <h1 class="mt-5 text-center">タイトルを表示</h1> -->
                        <h1 class="mt-5 text-center">{{ currentArticleData.title }}</h1>
                        <ArticleUserCardTag
                            :avatar-url="currentArticleData.user.avatar.url"
                            :user-nickname="currentArticleData.user.nickname"
                            :user-id="currentArticleData.user_id"
                            :level="currentArticleData.level_list"
                            :tags="currentArticleData.tag_list"
                        />
                        <!-- <p class="ml-2">{{ currentArticleData.user.nickname }}</p> -->
                        <div
                            class="d-flex mt-5"
                        >
                            <p>作成日:{{ $my.dataFormat(currentArticleData.created_at) }}</p>
                            <p class="ml-3">更新日:{{ $my.dataFormat(currentArticleData.updated_at) }}</p>
                        </div>
                        <div
                            class="mt-15"
                        >
                            <!-- eslint-disable-next-line vue/no-v-html -->
                            <div v-html="currentArticleData.content" />
                            <!-- {{ text }} -->
                            <!-- {{ currentArticleData }}
                            {{ currentArticleData.user.id }} -->
                            <!-- {{ currentArticleData.content }} -->
                        </div>
                    </v-card>
                </v-card>
                <v-card class="mt-8 pa-3">
                    <MainTitle title="Comment" />
                        <div v-if="articleComments.length > 0">
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
                                v-model="commentContent"
                                outlined
                                label="Comment"
                                class="mt-5"
                            >
                            </v-textarea>
                            <div class="text-right">
                                <v-btn
                                    color="primary"
                                    dark
                                    @click="commentPost"
                                >
                                    コメント
                                </v-btn>
                            </div>
                        </v-card>
                </v-card>
            </v-container>
        </div>
    </div>

</template>

<script>

// import { mapActions, mapGetters } from 'vuex'
import { mapGetters } from 'vuex'
import ErrorCard from '~/components/Molecules/ErrorCard.vue'
import AppImg from '~/components/Atom/App/AppNoImg.vue'
import ArticleUserCardTag from '~/components/Atom/Article/ArticleUserCardTag.vue'
import MainTitle from '~/components/Atom/App/AppMainTitle.vue'
import CardComment from '~/components/Organisms/Card/CardComment.vue'

export default {
    name: 'ArticleDetail',
    components: {
        AppImg,
        ArticleUserCardTag,
        MainTitle,
        CardComment,
        ErrorCard
    },
    data() {
        return {
            title: '',
            image: '',
            text: 'hello world',
            comment: 'a',
            on: false,
            dialog: false,
            commentContent: '',
        }
    },
    async fetch({ $axios, params, store }) {
        await $axios.$get(`/api/v1/articles/${params.id}`)
        // await $axios.$get(`api/v1/users/`)
            .then(res => {
                console.log(res)
                store.dispatch('modules/error/getErrorStatus', false)
                store.dispatch('modules/article/getCurrentArticleData', res)
                store.dispatch('modules/comment/getArticleComment', res.comments)

            })
            .catch(err => {
                console.log(err)
                store.dispatch('modules/error/getErrorStatus', true)
                store.dispatch('modules/toast/getToast', {
                    status: true,
                    msg: '存在しない記事です',
                    color: 'error'
                })
            })
    },
    computed: {
        ...mapGetters({
            currentArticleData: 'modules/article/getCurrentArticleData',
            currentUser: 'modules/user/getUser',
            articleComments: 'modules/comment/getArticleComment',
            error: 'modules/error/getErrorStatus',
        })
    },
    // beforeDestroy () {
    //     // Vueインスタンスが破棄される直前にVuexのtoast.msgを削除する(無期限toastに対応)
    //     this.resetArticle()
    // },
    methods: {
        resetArticle() {

            this.$store.dispatch('modules/article/getCurrentArticleData', null)
            this.$store.dispatch('modules/comment/getArticleComment', [])
        },
        async articleDelete() {
            await this.$axios.$delete(`/api/v1/articles/${this.$route.params.id}`)
                .then(res => {
                    // console.log(res)
                    // this.$auth.login(res)
                    // const status = true
                    // const msg = '削除が完了しました'
                    // this.$store.dispatch('modules/toast/getToast', { status, msg })
                    this.$router.push('/home')
                })
                .catch( err => {
                    console.log(err)
                    this.$store.dispatch('modules/toast/getToast', {
                        status: true,
                        msg: '練習メニュの削除に失敗しました',
                        color: 'error'
                    })
                })
            this.dialog = false
        },
        async commentPost() {
            const comment = {
                content: this.commentContent,
            }
            await this.$axios.$post(`/api/v1/articles/${this.$route.params.id}/comments`, comment)
                .then(res => {
                    const comment = {
                        id: res.id,
                        user_id: this.currentUser.id,
                        article_id: this.$route.params.id,
                        content: this.commentContent,
                        created_at: new Date(),
                        user: {
                            id: this.currentUser.id,
                            nickname: this.currentUser.nickname,
                            avatar: {
                                url: this.currentUser.avatar.url,
                            }
                        }
                    }
                    this.$store.commit('modules/comment/setPushArticleComment', comment)
                    this.commentContent = ''
                    this.$store.dispatch('modules/toast/getToast', {
                            status: true,
                            msg: '素敵なコメントをありがとう!!',
                            color: 'success'
                        })
                })
                .catch( err => {
                    console.log(err)
                    this.$store.dispatch('modules/toast/getToast', {
                            status: true,
                            msg: 'コメントの投稿に失敗しました',
                            color: 'error'
                        })
                })
        },

    },
};
</script>