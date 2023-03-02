<template>
    <v-row
        class="mt-2"
    >
        <v-col
            cols="3"
        >
            <div class="ml-3">
                <AvatarSwitch
                    :avatar-url="avatarUrl"
                    :id="userId"
                />
            </div>
        </v-col>
        <v-col
            cols="9"
        >
            <p>{{ userNickname }}</p>
        </v-col>
        <v-col
            cols="12"
            class="py-0"
        >
            <nuxt-link
                :to="`/levels/${level.id}`"
            >
                <div class="ml-2">
                    <v-chip
                        color="primary"
                        dark
                        label
                        small
                    >
                        <v-icon left>
                            mdi-label
                        </v-icon>
                        <!-- 大学生以上 -->
                        {{ level.name }}
                    </v-chip>
                </div>
            </nuxt-link>
        </v-col>
        <v-col
            cols="11"
            class="py-0 px-4"
        >
            <div v-if="tags.length">
                <div>
                    <v-icon>
                        mdi-tag-multiple
                    </v-icon>
                    <!-- TODO propsで受け取れるようにする -->
                    <v-chip
                        v-for="tag in limitCount(tags)"
                        :key="tag.id"
                        outlined
                        color="primary"
                        class="ml-1"
                        dark
                        small
                    >
                        <nuxt-link
                            :to="`/tags/${tag.id}`"
                        >
                            {{ tag.name }}
                        </nuxt-link>
                    </v-chip>
                </div>
            </div>
        </v-col>
    </v-row>
</template>

<script>

import AvatarSwitch from '~/components/Molecules/AvatarSwitch.vue'

export default {
    name: 'ArticleUserCardTag',
    components: {
        AvatarSwitch,
    },
    props: {
        avatarUrl: {
            type: String,
            default: '',
        },
        userNickname: {
            type: String,
            default: '',
        },
        userId: {
            type: Number,
            default: 0,
        },
        level: {
            type: Object,
            default: () => ({}),
        },
        // TODO tag情報を受け取れるようにする
        tags: {
            type: Array,
            default: () => [],
        }
    },
    data() {
        return {
            // avatarUrl: '',
        }
    },
    methods: {
        limitCount (lists) {
            return lists.slice(0, 2)
        }
    }
}
</script>