<template>
    <v-text-field
        v-model="setPassword"
        label="パスワードを入力"
        placeholder="8文字以上"
        outlined
        clearable
        color="blue"
    />
</template>

<script>
export default {
    props: {
        password: {
            type: String,
            default: ''
        }
    },
    computed: {
        setPassword: {
            get() { return this.password },
            set(newVal) { return this.$emit('update:password',newVal)}
        }
    }
}
</script>