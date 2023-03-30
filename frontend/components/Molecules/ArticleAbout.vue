<template>
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
        <ArticleUserCardTag
            :avatar-url="article.user.avatar.url"
            :user-nickname="article.user.nickname"
            :level="article.level_list"
            :user-id="article.user_id"
            :tags="article.tag_list"
        />
        <div class="pa-3">
            <nuxt-link
                :to="`/articles/${article.id}`"
            >
                <v-card-title class="text-h6">
                    {{ $my.shortVersion(article.title, 27) }}
                </v-card-title>
                <v-card-subtitle>
                    <!-- 作成日: 2023/02/06 -->
                    作成日:{{ $my.dataFormat(article.created_at) }}
                </v-card-subtitle>
            </nuxt-link>
            <div
                class="d-flex justify-end mb-2"
            >
                <div v-if="$my.liked(article.id)">
                    <v-icon>
                        mdi-heart
                    </v-icon>
                </div>
                <div v-else>
                    <v-icon>
                        mdi-heart-outline
                    </v-icon>
                </div>
                <div v-if="0 < article.likes.length" class="subheading mr-2 my-auto">{{ article.likes.length }}</div>
                <div
                    class="mr-3 my-auto"
                >
                    <nuxt-link
                        :to="`/articles/${article.id}`"
                    >
                        <v-icon>
                            mdi-comment-text-outline
                        </v-icon>
                        <span v-if="0 < article.comments.length" class="subheading">{{ article.comments.length }}</span>
                    </nuxt-link>
                </div>
            </div>
        </div>
    </v-card>
</template>

<script>
import ArticleUserCardTag from '~/components/Atom/Article/ArticleUserCardTag.vue'
import AppImg from '~/components/Atom/App/AppNoImg.vue'

export default {
    components: {
        ArticleUserCardTag,
        AppImg
    },
    props: {
        article: {
            type: Object,
            default: () => {}
        },
    },
}

</script>

<style lang="scss" scoped>
.v-application a {
    color: rgba(0,0,0,.87);
}
</style>