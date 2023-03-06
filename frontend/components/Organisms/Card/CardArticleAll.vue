<template>
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
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import ArticleMain from '~/components/Molecules/ArticleMain.vue'


export default {
    name: 'CardArticleAll',
    components: {
        ArticleMain
    },
    data() {
        return {
        }
    },
    computed: {
        ...mapGetters({
            articles: 'modules/article/getArticles',
            allLike: 'modules/like/getAllLike'
        })
    },
    async mounted() {
        await this.$axios.$get('/api/v1/articles')
            .then(res => {
                // console.log('articleのindexデータ', res)
                this.getArticles(res)
                const result = res.map(article => ({id: article.id, likes: article.likes}))
                // console.log('res', res)
                // console.log('result', result)
                this.dispatchLikes(result)

            })
            .catch(err => {
                console.log(err)
            })
    },
    methods: {
        ...mapActions({
            getArticles: 'modules/article/getArticles',
            dispatchLikes: 'modules/like/getAllLike'
        })
    }
}
</script>