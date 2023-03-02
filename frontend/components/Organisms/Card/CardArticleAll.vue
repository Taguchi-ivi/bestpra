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
    async mounted() {
        await this.$axios.$get('/api/v1/articles')
            .then(res => {
                // console.log('articleのindexデータ', res)
                this.getArticles(res)
            })
            .catch(err => {
                console.log(err)
            })
    },
    computed: {
        ...mapGetters({
            articles: 'modules/article/getArticles'
        })
    },
    methods: {
        ...mapActions({
            getArticles: 'modules/article/getArticles'
        })
    }
}
</script>