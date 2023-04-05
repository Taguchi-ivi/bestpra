<template>
    <p v-if="$auth.guestUser()">
        <!-- color="pink darken-1" -->
        <v-alert
            dense
            type="error"
        >
            {{ errMsg }}
        </v-alert>
    </p>
</template>

<script>
export default {
    props: {
        errMsg: {
            type: String,
            default: ''
        }
    }
}
</script>