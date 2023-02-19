<template>
    <!-- v-bind.valueは描写するためのもの -->
    <!-- v-input inputがあったときに発火する -->
    <!-- $emit('キー',$event) 子から親へ -->
    <!-- 本来 => @input="$emit('input',$event)" -->
    <!-- .sync => @input="$emit('update:name',$event)" -->
    <!-- より綺麗に => computedのget.setに記載 -->
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