<template>
    <div>
        <div>
            <v-container
                fluid
            >
                <v-row>
                    <v-col
                        cols="12" sm="3" md="3" lg="3" xl="3"
                        :class="$vuetify.breakpoint.xs ? 'mx-auto' : 'toc-view'"
                    >
                        <TagsContent
                            :current-tag-id="Number($route.params.id)"
                        />
                    </v-col>
                    <v-col
                        cols="12" sm="9" md="9" lg="9" xl="9"
                    >
                        <div v-if="error">
                            <p class="mt-5 text-center">タグから記事を検索!!</p>
                        </div>
                        <div v-else-if="articles.length === 0">
                            <p class="mt-5 text-center">まだ投稿されていません...</p>
                        </div>
                        <div v-else>
                            <v-row>
                                <v-col
                                    v-for="(article, index) in articles"
                                    :key="index"
                                    cols="12" sm="6" md="4" lg="4" xl="4"
                                >
                                    <ArticleMain
                                        :article="article"
                                    />
                                </v-col>
                            </v-row>
                        </div>
                    </v-col>
                </v-row>
            </v-container>
        </div>
    </div>
</template>

<script>
import TagsContent from '~/components/Atom/App/AppTags.vue'
import ArticleMain from '~/components/Molecules/ArticleMain.vue'

export default {
    name: 'Tags',
    components: {
        TagsContent,
        ArticleMain,
    },
    async asyncData({ $axios, store, params }) {
        const res = await $axios.$get(`/api/v1/tag_lists/${params.id}/article_tag`)
        if(res === 'bad_request') {
            store.dispatch('modules/toast/getToast', {
                        status: true,
                        msg: 'タグを選択しよう!',
                        color: 'info'
                    })
            return {
                error: true
            }
        }
        return {
            articles: res
        }
    },
    data() {
        return {
            error: false,
        }
    },
    head(){
        return {
            title: 'Tag Page',
        }
    },
}
</script>