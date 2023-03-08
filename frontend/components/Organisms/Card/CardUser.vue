<template>
    <div>
        <v-row>
            <v-col
                v-for="user in users"
                :key="user.id"
                class="d-flex justify-center"
                cols="12"
            >
                <UserMain
                    :user="user"
                />
            </v-col>
        </v-row>
    </div>
</template>

<script>
import UserMain from '~/components/Molecules/UserMain.vue'

export default {
    components: {
        UserMain,
    },
    props: {
        users: {
            type: Array,
            default: () => [],
        }
    }
}
</script>