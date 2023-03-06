<template>
    <div>
        <h2>likes</h2>
        <p v-if="likesArticle.length === 0">まだいいねされていません</p>
        <div v-else>
            <v-row>
                <v-col
                    v-for="(article, index) in likesArticle"
                    :key="index"
                    cols="4"
                >
                    <ArticleMain
                        :article="article"
                        :user-home-flg="$my.isCurrentUser($route.params.id)"
                    />
                </v-col>
            </v-row>
        </div>
    </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import ArticleMain from '~/components/Molecules/ArticleMain.vue'

export default {
    name: 'UserLikes',
    components: {
        ArticleMain
    },
    async fetch({ $axios, params, store}) {
        await $axios.$get(`/api/v1/users/${params.id}/likes`)
            .then(res => {
                // console.log('どう？', res)
                const result = res.map(item => ( item.article))
                store.dispatch('modules/article/getLikesArticle', result)

            })
            .catch(err => {
                console.log(err)
            })
    },
    computed: {
        ...mapGetters({
            currentUser: 'modules/user/getUser',
            likesArticle: 'modules/article/getLikesArticle',
        })
    },
    methods: {
        ...mapActions({
            dispatchLikesArticle: 'modules/article/getLikesArticle',
            dispatchLikes: 'modules/like/getAllLike'
        }),
    }
}
</script>