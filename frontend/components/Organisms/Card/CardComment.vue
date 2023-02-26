<template>
    <v-card
        width="80%"
        class="mr-auto pa-3"
    >
        <div
            class="d-flex"
        >
            <div>
                <!-- <v-avatar
                    color="indigo"
                    class="ml-3"
                >
                    <v-icon dark>
                        mdi-account-circle
                    </v-icon>
                </v-avatar> -->
                <!-- TODO 対象のidを付与する -->
                <AvatarSwitch
                    :id="1"
                    :avatar-url="avatarUrl"
                />
            </div>
            <div class="ml-5">
                <p class="ma-0">this.name</p>
                <p class="text-caption">作成日:2023/02/12</p>
            </div>
        </div>
        <p>content</p>
    </v-card>
</template>

<script>
import AvatarSwitch from '~/components/Molecules/AvatarSwitch.vue'

export default {
    components: {
        AvatarSwitch,
    },
    data() {
        return {
            avatarUrl: ''
        }
    }
}
</script>