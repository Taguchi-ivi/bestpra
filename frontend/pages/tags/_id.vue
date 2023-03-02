<template>
    <div>
        <div v-if="error">
            <ErrorCard
                title="存在しないタグです"
                message="404 not found"
            />
        </div>
        <div v-else>
            <v-container
                fluid
            >
                <v-row>
                    <v-col
                        cols="3"
                        class="toc-view"
                    >
                        <TagsContent
                            :current-tag-id="Number($route.params.id)"
                        />
                    </v-col>
                    <v-col
                        cols="9"
                    >
                        <div v-if="articles.length === 0">
                            <p class="mt-5 text-center">まだ投稿されていません...</p>
                        </div>
                        <div v-else>
                            <v-row>
                                <v-col
                                    v-for="(article, index) in articles"
                                    :key="index"
                                    cols="4"
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
import ErrorCard from '~/components/Molecules/ErrorCard.vue'
import TagsContent from '~/components/Atom/App/AppTags.vue'
import ArticleMain from '~/components/Molecules/ArticleMain.vue'

export default {
    name: 'Tags',
    components: {
        TagsContent,
        ErrorCard,
        ArticleMain
    },
    async asyncData({ $axios, store, params }) {
        const res = await $axios.$get(`/api/v1/tag_lists/${params.id}/article_tag`)
        if(res === 'bad_request') {
            store.dispatch('modules/toast/getToast', {
                        status: true,
                        msg: '存在しないタグです',
                        color: 'error'
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
    }
}
</script>