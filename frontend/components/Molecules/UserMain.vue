<template>
    <v-card
        width="80%"
        to="/" nuxt
        hover
        rounded
    >
        <div
            class="d-flex justify-start"
        >
            <!-- <v-list-item-avatar
                color="primary"
                class="ml-3"
            >
                <v-icon dark>
                    mdi-account-circle
                </v-icon>
            </v-list-item-avatar> -->
            <!-- TODO 対象のIDを付与する -->
            <div
                class="px-5 pt-5"
            >
                <AvatarSwitch
                    :avatar-url="user.avatar.url"
                />

            </div>
            <div
                :class="marginTop(user.id)"
            >
                <div class="text-h6">{{ user.nickname }}</div>
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
    methods: {
        marginTop(userId) {
            return this.$my.isFollowed(userId) ? 'mt-1' : 'mt-4'
        }
    },
}
</script>