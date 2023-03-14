<template>
    <div>
        <MainTitle
            title="いいね一覧"
        />
        <p v-if="likesArticle.length === 0" class="text-center">まだいいねされていません</p>
        <div v-else>
            <v-row>
                <v-col
                    v-for="(article, index) in likesArticle"
                    :key="index"
                    cols="12" sm="6" md="4" lg="4" xl="4"
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
import MainTitle from '~/components/Atom/App/AppMainTitle.vue'
import ArticleMain from '~/components/Molecules/ArticleMain.vue'

export default {
    name: 'UserLikes',
    components: {
        MainTitle,
        ArticleMain
    },
    async asyncData({ $axios, params, store }) {
        const res = await $axios.$get(`/api/v1/users/${params.id}/likes`)
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
        const result = res.map(item => ( item.article))
        store.dispatch('modules/article/getLikesArticle', result)
        return {
            error: false,
        }
    },
    data() {
        return {
            error: false
        }
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