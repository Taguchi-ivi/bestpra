<template>
    <div>
        <v-card
            max-width="250px"
            class="py-3 mx-auto mb-3"
            elevation="9"
            color="primary"
            dark
        >
            <p class="text-center mb-0">ラベル一覧</p>
        </v-card>
        <v-card
            class="mx-auto pa-5"
            max-width="250px"
            elevation="9"
            :color="cardColor"
        >
            <div
                v-for="level in levels"
                :key="level.id"
                class="mt-3"
            >
                <div v-if="level.id === currentLevelId">
                    <div class="ml-2">
                        <v-chip
                            color="primary"
                            dark
                            label
                            link
                        >
                            <v-icon left>
                                mdi-label
                            </v-icon>
                            {{ level.name }}
                        </v-chip>
                    </div>
                </div>
                <div v-else>
                    <div class="ml-2">
                        <v-chip
                            color="primary"
                            dark
                            label
                            small
                            link nuxt
                            :to="`/levels/${level.id}`"
                            outlined
                        >
                            <v-icon left>
                                mdi-label
                            </v-icon>
                            {{ level.name }}
                        </v-chip>
                    </div>
                </div>
            </div>
        </v-card>
    </div>
</template>

<script>
export default {
    data() {
        return {
            levels: [],
        }
    },
    props: {
        currentLevelId: {
            type: Number,
            default: 0,
        },
        cardColor: {
            type: String,
            default: 'transparent',
        }
    },
    async mounted() {
        await this.$axios.$get('/api/v1/level_lists')
            .then(res => {
                this.levels = res
            })
            .catch(err => {
                console.log(err)
            })
    },
}
</script>