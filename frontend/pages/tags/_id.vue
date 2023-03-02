<template>
    <div>
        <div v-if="error">
            <ErrorCard
                title="存在しないタグです"
                message="404 not found"
                content="tag"
            />
        </div>
        <div v-else>
            <v-container
                fluid
            >
                <v-row>
                    <v-col
                        cols="3"
                        class="toc-view"
                    >
                        <TagsContent />
                    </v-col>
                    <v-col
                        cols="9"
                    >
                        
                    </v-col>
                </v-row>
            </v-container>
        </div>
    </div>
</template>

<script>
import ErrorCard from '~/components/Molecules/ErrorCard.vue'
import TagsContent from '~/components/Atom/App/AppTags.vue'

export default {
    name: 'Tags',
    components: {
        TagsContent,
        ErrorCard,
    },
    async asyncData({ $axios, params }) {
        const level = await $axios.$get(`/api/levels/${params.id}`)
        // return { level }
        if(res === 'bad_request') {
            store.dispatch('modules/toast/getToast', {
                        status: true,
                        msg: '存在しないタグです',
                        color: 'error'
                    })
            return {
                error: true
            }
        }
        // nameだけの配列に変更
        const tagList = res.tag_list.map(item => item.name)
        return {
            level: {
                id: res.level_list_id,
                name: '',
            },
            text: res.content,
            title: res.title,
            imageUrl: res.image.url,
            // tag_list: list,
            tag_list: tagList
        }
    },
    data() {
        return {
            error: false,
        }
    }
}
</script>