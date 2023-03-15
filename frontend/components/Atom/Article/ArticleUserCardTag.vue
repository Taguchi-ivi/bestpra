<template>
    <div
        class="mt-2"
    >
        <div
            class="d-flex"
        >
            <div class="ml-3">
                <AvatarSwitch
                    :avatar-url="avatarUrl"
                    :id="userId"
                />
            </div>
            <div
                :class="$my.userMarginTop(userId)"
            >
                <p class="ma-0 ml-3">{{ $my.shortVersion(userNickname, 15) }}</p>
                <div
                    v-if="$my.isFollowed(userId)"
                    class="text-caption mr-auto"
                >
                    <v-chip
                        x-small
                    >
                        フォロー済み
                    </v-chip>
                </div>
            </div>
        </div>
        <div
            class="py-0 mt-3"
        >
            <div class="ml-2">
                <v-chip
                    color="primary"
                    dark
                    label
                    small
                    link nuxt
                    :to="`/levels/${level.id}`"
                >
                    <v-icon left>
                        mdi-label
                    </v-icon>
                    {{ level.name }}
                </v-chip>
            </div>
        </div>
        <div
            class="py-0 px-4"
        >
            <div v-if="tags.length">
                <div>
                    <v-icon>
                        mdi-tag-multiple
                    </v-icon>
                    <v-chip
                        v-for="tag in limitCount(tags)"
                        :key="tag.id"
                        outlined
                        color="primary"
                        class="ml-1"
                        dark
                        small
                        link nuxt
                        :to="`/tags/${tag.id}`"
                    >
                        {{ tag.name }}
                    </v-chip>
                </div>
            </div>
        </div>
    </div>
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
        tags: {
            type: Array,
            default: () => [],
        }
    },
    methods: {
        limitCount (lists) {
            return lists.slice(0, 2)
        },
    }
}
</script>