<template>
    <v-row>
        <v-col
            v-for="n in 12"
            :key="n"
            class="d-flex justify-center"
            cols="12"
        >
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
                        color="indigo"
                        class="ml-3"
                    >
                        <v-icon dark>
                            mdi-account-circle
                        </v-icon>
                    </v-list-item-avatar> -->
                    <!-- TODO 対象のIDを付与する -->
                    <div
                        class="pa-5"
                    >
                        <AvatarSwitch
                            :avatarUrl="avatarUrl"
                        />

                    </div>
                    <div>
                        <div class="text-h6 mt-3">this.name</div>
                        <div class="text-caption mr-auto">フォロー済み</div>
                    </div>
                </div>
                <v-card-subtitle>
                    introduction
                </v-card-subtitle>
            </v-card>
        </v-col>
    </v-row>
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