<template>
    <v-text-field
        v-model="setPassword"
        :rules="form.rules"
        :hint="form.hint"
        :disabled="disabled"
        label="パスワードを入力"
        :placeholder="form.placeholder"
        :hide-details="!setValidation"
        :counter="setValidation"
        color="blue"
        :append-icon="toggle.icon"
        :type="toggle.type"
        outlined
        autocomplate="on"
        @click:append="show = !show"
    />
</template>

<script>
export default {
    props: {
        password: {
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
        setPassword: {
            get() { return this.password },
            set(newVal) { return this.$emit('update:password',newVal)}
        },
        form() {
            const min = '8文字以上'
            const msg = `${min}。半角英数字・ﾊｲﾌﾝ・アンダーバーが使えます`
            // signin(再ログイン時) 入力必須 => setValidation = false
            // signup(会員登録) 入力必須,8文字以上,72文字以下,書式チェック => setValidation=true
            const required = v => !!v || ''
            const format = v => /^[\w-]{8,72}$/.test(v) || msg

            const rules = this.setValidation ? [format] : [required]
            const hint = this.setValidation ? msg : ''
            const placeholder = this.setValidation ? min : ''

            return { rules, hint, placeholder }
        },
        toggle() {
            const icon = this.show ? 'mdi-eye': 'mdi-eye-off'
            const type = this.show ? 'text' : 'password'
            return { icon, type }
        }
    }
}
</script>