<template>
    <div>
        <v-card
            max-width="350px"
            class="py-3 mx-auto mb-3"
            elevation="9"
            color="primary"
            dark
        >
            <p class="text-center mb-0">タグ一覧</p>
        </v-card>
        <v-card
            class="mx-auto pa-3 scroll"
            max-width="350px"
            max-height="300px"
            elevation="9"
            :color="cardColor"
        >
            <span
                v-for="tag in tags"
                :key="tag.id"
                class="ma-1"
            >
                <span v-if="tag.id === currentTagId">
                    <v-chip
                        class="ma-1"
                        color="primary"
                        dark
                    >
                    <v-icon left>
                        mdi-label
                    </v-icon>
                    {{ tag.name }}
                    </v-chip>
                </span>
                <span v-else>
                    <v-chip
                        class="ma-1"
                        color="primary"
                        link nuxt
                        :to="`/tags/${tag.id}`"
                        outlined
                    >
                    <v-icon left>
                        mdi-label
                    </v-icon>
                    {{ tag.name }}
                    </v-chip>
                </span>
            </span>
        </v-card>
    </div>
</template>

<script>
export default {
    data() {
        return {
            tags: [],
        }
    },
    props: {
        currentTagId: {
            type: Number,
            default: 0,
        },
        cardColor: {
            type: String,
            default: 'transparent',
        }
    },
    async mounted() {
        await this.$axios.$get('/api/v1/tag_lists')
            .then(res => {
                // tag_listのnameだけの配列を作成する
                this.tags = res
            })
            .catch(err => {
                console.log(err)
            })
    },
}
</script>

<style>
.scroll {
    overflow-y: scroll;
}
</style>