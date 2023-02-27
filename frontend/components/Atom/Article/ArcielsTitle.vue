<template>
    <v-text-field
        v-model="setTitle"
        label="タイトル"
        required
        color="indigo"
    >
    </v-text-field>
</template>

<script>
export default {
    computed: {
        setTitle: {
            get() { return this.title },
            set(newVal) { this.$emit('update:title', newVal) }
        },
    }
}
</script>