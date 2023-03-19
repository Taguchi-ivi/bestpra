<template>
    <div>
        <v-card
            max-width="80%"
            class="mx-auto pa-3"
            color="transparent"
            flat
        >
            <v-text-field
                v-model="searchArticle"
                label="練習メニュー検索"
                solo
                prepend-inner-icon="mdi-magnify"
                class="mx-auto mt-8"
            >
            </v-text-field>
            <div v-if="loading">
                <TheLoading />
            </div>
            <div v-else>
                <div class="text-right py-4">
                    <span>検索結果: {{ articles.length }}件</span>
                </div>
                <v-row>
                    <v-col
                        v-for="(article, index) in articles"
                        :key="index"
                        cols="12" sm="6" md="6" lg="6" xl="4"
                    >
                        <ArticleMain
                            :article="article"
                        />
                    </v-col>
                </v-row>
            </div>
        </v-card>
    </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import _ from 'lodash'
import ArticleMain from '~/components/Molecules/ArticleMain.vue'
import TheLoading from '~/components/Organisms/Application/TheLoading.vue'

export default {
    components: {
        ArticleMain,
        TheLoading
    },
    data() {
        return {
            loading: false,
            searchArticle: '',
        }
    },
    computed: {
        ...mapGetters({
            articles: 'modules/article/getSearchArticles',
        })
    },
    watch: {
        searchArticle() {
            this.dispatchResetArticles()
            if(this.searchArticle.length > 0) {
                this.delayFunc()
            }
        }
    },
    // mounted() {
    //     this.dispatchResetArticles()
    // },
    created() {
        this.delayFunc = _.debounce(this.search, 500)
    },
    methods: {
        ...mapActions({
            dispatchArticles: 'modules/article/getSearchArticles',
            dispatchResetArticles: 'modules/article/getResetSearchArticles',
        }),
        async search() {
            this.loading = true
            await this.$axios.get('/api/v1/articles/search', {
                params: {
                    keyword: this.searchArticle
                }
            })
                .then(res => {
                    res.data.length > 0 ? this.dispatchArticles(res.data) : this.dispatchResetArticles()
                })
                .catch(err => {
                    console.log(err)
                })
            this.loading = false
        }
    },
}
</script>