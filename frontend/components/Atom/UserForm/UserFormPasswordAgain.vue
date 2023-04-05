<template>
    <v-text-field
        v-model="setPasswordAgain"
        :rules="form.rules"
        :disabled="disabled"
        label="確認用パスワード"
        color="blue"
        :append-icon="toggle.icon"
        :hide-details="!setValidation"
        :counter="setValidation"
        :type="toggle.type"
        outlined
        autocomplate="on"
        @click:append="show = !show"
    />
</template>

<script>
export default {
    props: {
        passwordAgain: {
            type: String,
            default: ''
        },
        setValidation: {
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
            show: false
        }
    },
    computed: {
        setPasswordAgain: {
            get() { return this.passwordAgain },
            set(newVal) { return this.$emit('update:passwordAgain',newVal)}
        },
        form() {
            const min = '8文字以上'
            const msg = `${min}72文字未満`
            // signin(再ログイン時) 入力必須 => setValidation = false
            // signup(会員登録) 入力必須,8文字以上,72文字以下,書式チェック => setValidation=true
            const required = v => !!v || ''
            const format = v => /^[\w-]{8,72}$/.test(v) || msg
            const rules = this.setValidation ? [format] : [required]
            return { rules }
        },
        toggle() {
            const icon = this.show ? 'mdi-eye': 'mdi-eye-off'
            const type = this.show ? 'text' : 'password'
            return { icon, type }
        }
    }
}
</script>