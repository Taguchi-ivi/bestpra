<template>
    <!-- v-bind.valueは描写するためのもの -->
    <!-- v-input inputがあったときに発火する -->
    <!-- $emit('キー',$event) 子から親へ -->
    <!-- 本来 => @input="$emit('input',$event)" -->
    <!-- .sync => @input="$emit('update:name',$event)" -->
    <!-- より綺麗に => computedのget.setに記載 -->
    <v-text-field
        v-model="setName"
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
        name: {
            type: String,
            default: ''
        }
    },
    computed: {
        setName: {
            get() { return this.name },
            set(newVal) { return this.$emit('update:name',newVal)}
        }
    }
}
</script>