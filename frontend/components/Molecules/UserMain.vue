<template>
    <v-card
        width="80%"
        :to="`/users/${user.id}/articles`" nuxt
        hover
        rounded
    >
        <div
            class="d-flex justify-start"
        >
            <div
                class="px-5 pt-5"
            >
                <AvatarSwitch
                    :avatar-url="user.avatar.url"
                />

            </div>
            <div
                :class="$my.userMarginTop(user.id)"
            >
                <div :class="$vuetify.breakpoint.xs ? 'text-body-1' : 'text-h6'">{{ user.nickname }}</div>
                <div
                    v-if="$my.isFollowed(user.id)"
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
        <v-card-subtitle>
            {{ user.introduction }}
        </v-card-subtitle>
    </v-card>
</template>

<script>
import AvatarSwitch from '~/components/Molecules/AvatarSwitch.vue'
export default {
    components: {
        AvatarSwitch,
    },
    props: {
        user: {
            type: Object,
            default: () => {}
        }
    },
    data() {
        return {
            avatarUrl: ''
        }
    },
}
</script>