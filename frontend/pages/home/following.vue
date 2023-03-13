<template>
    <div>
        <MainTitle
            title="フォロー中"
        />
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
</template>


<script>
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
    },
}
</script>