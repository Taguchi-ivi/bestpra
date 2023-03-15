<template>
    <v-text-field
        v-model="setName"
        :rules="rules"
        :counter="max"
        label="ユーザー名を入力"
        placeholder="あなたの表示名"
        outlined
        clearable
        color="blue"
    />
</template>

<script>
export default {
    props: {
        nickname: {
            type: String,
            default: ''
        }
    },
    data() {
        const max = 30;
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
        setName: {
            get() { return this.nickname },
            set(newVal) { return this.$emit('update:nickname',newVal)}
        }
    }
}
</script>