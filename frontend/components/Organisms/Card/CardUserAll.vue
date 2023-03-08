<template>
    <v-row>
        <v-col
            v-for="n in 12"
            :key="n"
            class="d-flex justify-center"
            cols="12"
        >
            <UserMain />
        </v-col>
    </v-row>
</template>

<script>
import UserMain from '~/components/Molecules/UserMain.vue'
export default {
    components: {
        UserMain,
    },
    data() {
        return {
            avatarUrl: ''
        }
    }
}
</script>