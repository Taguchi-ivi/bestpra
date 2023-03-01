<template>
    <v-row
        class="mt-2"
    >
        <v-col
            cols="3"
        >
            <!-- <v-list-item-avatar
                class="ml-3"
            > -->
                <!-- <v-icon dark>
                    mdi-account-circle
                </v-icon> -->
                <div class="ml-3">
                    <!-- TODO idを対象のIDを付与すること -->
                    <AvatarSwitch
                        :avatar-url="avatarUrl"
                        :id="userId"
                    />
                </div>
            <!-- </v-list-item-avatar> -->
        </v-col>
        <v-col
            cols="9"
        >
            <div>
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
            <div v-if="tags.length">
                <div class="mt-1">
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
                        {{ tag.name }}
                    </v-chip>
                </div>
            </div>
        </v-col>
    </v-row>
</template>

<script>

import AvatarSwitch from '~/components/Molecules/AvatarSwitch.vue'

export default {
    name: 'UserCardTag',
    components: {
        AvatarSwitch,
    },
    props: {
        avatarUrl: {
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