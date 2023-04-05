<template>
    <v-text-field
        v-model="setEmail"
        :rules="rules"
        :disabled="disabled"
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
        },
        disabled: {
            type: Boolean,
            default: false
        }
    },
    data() {
        return {
            rules: [
                // 入力必須
                v => !!v || '',
                // メアドの形式を簡易的にチェック
                v => /^[A-Za-z0-9]{1}[A-Za-z0-9_.-]*@{1}[A-Za-z0-9_.-]+.[A-Za-z0-9]+$/.test(v) || ''
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