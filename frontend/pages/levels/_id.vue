<template>
    <div>
        <div v-if="error">
            <ErrorCard
                title="存在しない対象者です"
                message="404 not found"
                content="level"
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
                        <LevelContent />
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
import LevelContent from '~/components/Atom/App/AppLelvels.vue'

export default {
    name: 'Levels',
    components: {
        LevelContent,
    },
    async asyncData({ $axios, params }) {
        const level = await $axios.$get(`/api/levels/${params.id}`)
        // return { level }
        if(res === 'bad_request') {
            store.dispatch('modules/toast/getToast', {
                        status: true,
                        msg: '存在しない練習メニュです',
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
