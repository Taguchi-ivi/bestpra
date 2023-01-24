<template>
    <v-text-field
        v-model="setEmail"
        label="メールアドレスを入力"
        placeholder="your@email.com"
        outlined
        clearable
        color="blue"
    />
</template>

<script>
export default {
    props: {
        email: {
            type: String,
            default: ''
        }
    },
    computed: {
        setEmail: {
            get() { return this.email },
            set(newVal) { return this.$emit('update:email',newVal)}
        }
    }
}
</script>