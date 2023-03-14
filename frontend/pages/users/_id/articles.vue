<template>
    <div>
        <MainTitle
            title="練習メニュー"
        />
        <div v-if="writtenArticles.length === 0">
            <p>まだ投稿はありません</p>
        </div>
        <div v-else>
            <v-row>
                <v-col
                    v-for="(article, index) in writtenArticles"
                    :key="index"
                    cols="12" sm="6" md="4" lg="4" xl="4"
                >
                    <ArticleMain
                        :article="article"
                    />
                </v-col>
            </v-row>
        </div>
    </div>
</template>

<script>
import MainTitle from '~/components/Atom/App/AppMainTitle.vue'
import ArticleMain from '~/components/Molecules/ArticleMain.vue'

export default {
    name: 'UsersArticles',
    components: {
        MainTitle,
        ArticleMain,
    },
    async asyncData({ $axios, params, store}) {
        const res = await $axios.$get(`/api/v1/users/${params.id}/written_articles`)
        if(res === 'bad_request') {
            store.dispatch('modules/toast/getToast', {
                        status: true,
                        msg: '存在しないユーザーです',
                        color: 'error'
                    })
            return {
                error: true
            }
        }
        return {
            error: false,
            writtenArticles: res,
        }
    },
}
</script>