<template>
    <v-container>
        <nuxt-child />
    </v-container>
</template>

<script>
export default {
    // falseを返すページをアクセス制限に
    validate({ route }) {
        // console.log('↓')
        // console.log(route.name)
        return route.name !== 'account'
    }
}
</script>