<template>
    <v-text-field
        v-model="setEmail"
        :rules="rules"
        label="メールアドレスを入力"
        :placeholder="placeholder ? 'your@email.com' : undefined"
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
        },
        placeholder: {
            type: Boolean,
            default: false
        }
    },
    data() {
        return {
            rules: [
                // 入力必須
                v => !!v || '',
                // メアドの形式チェック
                v => /.+@.\..+/.test(v) || ''
            ]
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