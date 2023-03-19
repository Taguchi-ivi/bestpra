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
                                v-if="$my.liked(currentArticleData.id)"
                                icon
                                @click="$my.unlike(currentArticleData, false, false)"
                            >
                                <v-icon
                                    size="30"
                                    color="red"
                                >
                                    mdi-heart
                                </v-icon>
                            </v-btn>
                            <v-btn
                                v-else
                                icon
                                @click="$my.createLike(currentArticleData, false)"
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
                        <div
                            class="mt-5 text-center"
                            :class="$vuetify.breakpoint.xs ? 'text-h5' : 'text-h3'"
                        >
                            {{ currentArticleData.title }}
                        </div>
                        <ArticleUserCardTag
                            :avatar-url="currentArticleData.user.avatar.url"
                            :user-nickname="currentArticleData.user.nickname"
                            :user-id="currentArticleData.user_id"
                            :level="currentArticleData.level_list"
                            :tags="currentArticleData.tag_list"
                        />
                        <div
                            :class="$vuetify.breakpoint.xs ? '' : 'd-flex'"
                            class="mt-5"
                        >
                            <p class="mb-0">作成日:{{ $my.dataFormat(currentArticleData.created_at) }}</p>
                            <p :class="$vuetify.breakpoint.xs ? '' : 'ml-3'">更新日:{{ $my.dataFormat(currentArticleData.updated_at) }}</p>
                        </div>
                        <div
                            class="mt-15 ck-content ck-content-a"
                        >
                            <!-- eslint-disable-next-line vue/no-v-html -->
                            <div v-html="currentArticleData.content" />
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
                                    :disabled="!commentContent || loading"
                                    :loading="loading"
                                    color="primary"
                                    class="white--text"
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

import { mapGetters, mapActions, mapMutations } from 'vuex'
import AppImg from '~/components/Atom/App/AppNoImg.vue'
import ErrorCard from '~/components/Molecules/ErrorCard.vue'
import ArticleUserCardTag from '~/components/Atom/Article/ArticleUserCardTag.vue'
import MainTitle from '~/components/Atom/App/AppMainTitle.vue'
import CardComment from '~/components/Organisms/Card/CardComment.vue'

export default {
    name: 'ArticleDetail',
    components: {
        ArticleUserCardTag,
        MainTitle,
        CardComment,
        ErrorCard,
        AppImg,
    },
    data() {
        return {
            loading: false,
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
            .then(res => {
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
    head(){
        return {
            title: 'Article Show Page',
        }
    },
    computed: {
        ...mapGetters({
            currentArticleData: 'modules/article/getCurrentArticleData',
            currentUser: 'modules/user/getUser',
            articleComments: 'modules/comment/getArticleComment',
            error: 'modules/error/getErrorStatus',
        })
    },
    methods: {
        ...mapActions({
            dispatchCurrentUser: 'modules/user/getCurrentUser',
        }),
        ...mapMutations({
            commitArticleComment: 'modules/comment/setPushArticleComment',
        }),
        // resetArticle() {
        //     this.$store.dispatch('modules/article/getCurrentArticleData', null)
        //     this.$store.dispatch('modules/comment/getArticleComment', [])
        // },
        async articleDelete() {
            await this.$axios.$delete(`/api/v1/articles/${this.$route.params.id}`)
                .then(res => {
                    this.$my.dispatchToast(true, '削除が完了しました', 'success')
                    this.$router.push('/home/all')
                })
                .catch( err => {
                    console.log(err)
                    this.$my.dispatchToast(true, '練習メニュの削除に失敗しました', 'error')
                })
            this.dialog = false
        },
        async commentPost() {
            if(!this.commentContent) {
                return this.$my.dispatchToast(true, 'コメントを入力してください', 'error')
            }
            this.loading = true
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
                    this.commitArticleComment(comment)
                    this.commentContent = ''
                    this.$my.dispatchToast(true, '素敵なコメントをありがとう!!', 'success')
                })
                .catch( err => {
                    console.log(err)
                    this.$my.dispatchToast(true, 'ニックネームは必須です', 'error')
                })
            this.loading = false
        },

    },
};
</script>