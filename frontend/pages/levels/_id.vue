<template>
    <div>
        <div v-if="error">
            <ErrorCard
                title="存在しないラベルです"
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
                        <LevelContent
                            :current-level-id="Number($route.params.id)"
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
                                    <!-- <v-card>{{ article }}</v-card> -->
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
import LevelContent from '~/components/Atom/App/AppLevels.vue'
import ArticleMain from '~/components/Molecules/ArticleMain.vue'

export default {
    name: 'Levels',
    components: {
        ErrorCard,
        LevelContent,
        ArticleMain
    },
    async asyncData({ $axios, store, params }) {
        const res = await $axios.$get(`/api/v1/level_lists/${params.id}/article_level`)
        // console.log('levelのindexデータ', res)
        if(res === 'bad_request') {
            store.dispatch('modules/toast/getToast', {
                        status: true,
                        msg: '存在しないラベルです',
                        color: 'error'
                    })
            return {
                error: true
            }
        }
        return {
            articles: res,
        }
    },
    data() {
        return {
            error: false,
        }
    }
}
</script>
