<template>
    <div
        class="pa-8"
    >
        <v-card
            class="mx-auto pa-5"
            max-width="600px"
        >
            <v-card-title>
                <h1>{{ title }}</h1>
            </v-card-title>
            <v-card-text>
                <p>{{ message }}</p>
            </v-card-text>
            <div v-if="content === 'home'">
                <div class="text-center">
                    <v-btn
                        @click="$router.push('/home/all')"
                        icon
                    >
                        <v-icon>
                            mdi-home
                        </v-icon>
                        homeへ
                    </v-btn>
                </div>
            </div>
            <!-- ロード時間がかかるため一旦なし -->
            <!-- content="level" -->
            <!-- content="tag" -->
            <!-- <div v-if="content === 'level'">
                <LevelContent />
            </div>
            <div v-if="content === 'tag'">
                <TagsContent />
            </div> -->
        </v-card>
    </div>
</template>

<script>
// import LevelContent from '~/components/Atom/App/AppLevels.vue'
// import TagsContent from '~/components/Atom/App/AppTags.vue'

export default {
    components: {
        // LevelContent,
        // TagsContent
    },
    props: {
        title: {
            type: String,
            default: ''
        },
        message: {
            type: String,
            default: ''
        },
        content: {
            type: String,
            default: 'home'
        }
    }
}
</script>