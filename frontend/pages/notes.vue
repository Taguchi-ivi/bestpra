<template>
    <v-container>
        {{ $route.fullPath }}
        <nuxt-child />
    </v-container>
</template>

<script>
export default {
    // validate({ route }) {
    //     return route.name !== 'notes'
    // }
}
</script>