<template>
    <div>
        <div v-if="loading">
            <TheLoading />
        </div>
        <div v-else>
            <MainTitle
                title="練習メニュー"
            />
            <CardArticle />
            <div class="d-flex justify-center my-10">
                <nuxt-link
                    to="/articles"
                >
                    <v-icon>
                        mdi-chevron-double-right
                    </v-icon>
                </nuxt-link>
            </div>
            <MainTitle
                title="練習ノート"
            />
            <CardNote />
            <div class="d-flex justify-center my-10">
                <nuxt-link
                    to="/articles"
                >
                    <v-icon>
                        mdi-chevron-double-right
                    </v-icon>
                </nuxt-link>
            </div>
        </div>
    </div>
</template>


<script>
import MainTitle from '~/components/Atom/MainTitle.vue'
import CardArticle from '~/components/Atom/Card/CardArticle.vue'
import CardNote from '~/components/Atom/Card/CardNote.vue'
import TheLoading from '~/components/Organisms/Application/TheLoading.vue'

export default {
    // middleware: 'get-article-current',
    // middleware: ['before-login-user'],
    components: {
        MainTitle,
        CardArticle,
        CardNote,
        TheLoading
    },
    layout: 'home',
    data() {
        return {
            users: {},
            loading: true
        }
    },
    created() {
        this.loading = false
    },
    methods: {
        testBtn() {
            // const user = {
            //     nickname: this.params.user.name,
            //     email: this.params.user.email,
            //     uid: 'aaaaaaaaaa'
            // }
            // this.$axios.post('/api/v1/users', { user })
            //     .then(response => {
            //             console.log(response)
            //         })
            // this.$axios.get('/api/v1/users')
            //     .then(response => {
            //         this.users = response.data
            //     })
        },
    },
}
</script>