<template>
    <v-text-field
        v-model="setPasswordAgain"
        label="確認用パスワード"
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
        passwordAgain: {
            type: String,
            default: ''
        },
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
        toggle() {
            const icon = this.show ? 'mdi-eye': 'mdi-eye-off'
            const type = this.show ? 'text' : 'password'
            return { icon, type }
        }
    }
}
</script>