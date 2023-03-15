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
                        <LevelContent
                            :current-level-id="Number($route.params.id)"
                        />
                    </v-col>
                    <v-col
                        cols="12" sm="9" md="9" lg="9" xl="9"
                    >
                        <div v-if="error">
                            <p class="mt-5 text-center">ラベルを検索しよう!!!</p>
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
import LevelContent from '~/components/Atom/App/AppLevels.vue'
import ArticleMain from '~/components/Molecules/ArticleMain.vue'

export default {
    name: 'Levels',
    components: {
        LevelContent,
        ArticleMain,
    },
    async asyncData({ $axios, store, params }) {
        const res = await $axios.$get(`/api/v1/level_lists/${params.id}/article_level`)
        if(res === 'bad_request') {
            store.dispatch('modules/toast/getToast', {
                        status: true,
                        msg: 'ラベルを選択しよう!',
                        color: 'info'
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
    },
    head(){
        return {
            title: 'Label Page',
        }
    },
}
</script>
