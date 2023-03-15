<template>
    <v-text-field
        v-model="setTitle"
        :rules="rules"
        :counter="max"
        label="タイトル"
    >
    </v-text-field>
</template>

<script>
export default {
    props: {
        title: {
            type: String,
            default: ''
        }
    },
    data() {
        const max = 80;
        return {
            max,
            rules: [
                // 入力必須
                // v => 正しい式 || 'エラーメッセージ'
                v => !!v || '',
                // 30文字まで
                v => (!!v && max >= v.length) || `${max}文字以内で入力してください`
            ]
        }
    },
    computed: {
        setTitle: {
            get() { return this.title },
            set(newVal) { this.$emit('update:title', newVal) }
        },
    }
}
</script>