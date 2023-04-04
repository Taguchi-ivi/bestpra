<template>
    <p v-if="$auth.guestUser()">
        <v-alert
            border="left"
            color="pink darken-1"
            dark
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