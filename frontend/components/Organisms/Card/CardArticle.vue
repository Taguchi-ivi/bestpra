<template>
    <v-row>
        <!-- v-for="n in 12" -->
        <!-- class="d-flex justify-center"
            cols="4"
        -->
        <v-col
            v-for="(article, index) in articles"
            :key="index"
            cols="4"
        >
            <!-- :to="`/articles/${article.id}`" nuxt
            hover -->
            <v-card
                width="300"
                rounded
            >
                <nuxt-link
                    :to="`/articles/${article.id}`"
                >

                    <AppImg
                        :img-url="article.image.url"
                        card-flg
                    />
                </nuxt-link>
                <!-- TODO tagデータを受け渡す -->
                <!-- :tag="article.tag.name" -->
                <UserCardTag
                    :avatar-url="article.user.avatar.url"
                    :level="article.level_name"
                    :user-id="article.user_id"
                />
                <div class="pa-3">
                    <!-- <v-divider /> -->
                    <!-- this.title -->
                    <nuxt-link
                        :to="`/articles/${article.id}`"
                    >
                        <v-card-title class="text-h6">
                            {{ article.title }}
                        </v-card-title>
                        <v-card-subtitle>
                            <!-- 作成日: 2023/02/06 -->
                            作成日:{{ $my.dataFormat(article.created_at) }}
                        </v-card-subtitle>
                    </nuxt-link>
                    <div
                        class="d-flex justify-end mb-2"
                    >
                        <div>
                            <v-icon>
                                mdi-heart-outline
                            </v-icon>
                            <span class="subheading mr-2">256</span>
                        </div>
                        <div
                            class="mr-3"
                        >
                            <nuxt-link
                                :to="`/articles/${article.id}`"
                            >
                                <v-icon>
                                    mdi-comment-text-outline
                                </v-icon>
                                <span class="subheading">45</span>
                            </nuxt-link>
                        </div>
                    </div>
                </div>
            </v-card>
        </v-col>
    </v-row>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import UserCardTag from '~/components/Molecules/UserCardTag.vue'
import AppImg from '~/components/Atom/App/AppNoImg.vue'

export default {
    components: {
        UserCardTag,
        AppImg
    },
    data() {
        return {
        }
    },
    async mounted() {
        await this.$axios.$get('/api/v1/articles')
            .then(res => {
                console.log('articleのindexデータ', res)
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