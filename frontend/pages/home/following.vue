<template>
    <div>
        <MainTitle
            title="フォロー中"
        />
        <v-row>
            <v-col
                v-for="(article, index) in articles"
                :key="index"
                cols="4"
            >
                <ArticleMain
                    :article="article"
                />
                <!-- <v-card>
                    {{article}}
                </v-card> -->
            </v-col>
        </v-row>
    </div>
</template>


<script>
// import { mapGetters } from 'vuex'
import MainTitle from '~/components/Atom/App/AppMainTitle.vue'
import ArticleMain from '~/components/Molecules/ArticleMain.vue'

export default {
    name: 'ClientHomeFollowing',
    components: {
        MainTitle,
        ArticleMain,
    },
    async asyncData({$axios}) {
        const res = await $axios.$get('/api/v1/following_articles')
        return {
            articles: res,
        }
            // .then(res => {
            //     const followingArticles = res.map(item => (item.articles))
            //     store.dispatch('modules/article/getArticles', followingArticles)

            //     const result = res.map(item => ({id: item.articles.id, likes: item.articles.likes}))
            //     store.dispatch('modules/like/getAllLike', result)
            // })
            // .catch(err => {
            //     console.log(err)
            // })
    },
    // computed: {
    //     ...mapGetters({
    //         articles: 'modules/article/getArticles',
    //         allLike: 'modules/like/getAllLike'
    //     })
    // },
}
</script>