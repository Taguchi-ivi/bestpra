<template>
    <v-card
        max-width="200"
        flat
        color="transparent"
        class="ml-auto"
    >
        <v-select
            v-model="setLevel"
            :items="levelItem"
            item-text="name"
            item-value="id"
            class="mb-10"
            menu-props="auto"
            label="対象者を選択"
            prepend-icon="mdi-label"
            single-line
            chips
            placeholder="対象者を選択してください"
            :rules="rules"
            required
            return-object
        >
        </v-select>
    </v-card>
</template>

<script>

export default {
    props: {
        level: {
            type: Object,
            default: () => {},
        },
    },
    data() {
        return {
            levelItem: [],
            rules: [
                // 入力必須
                // v => 正しい式 || 'エラーメッセージ'
                v => Object.keys(v).length > 0 || ''
            ]
        }
    },
    computed: {
        setLevel: {
            get() { return this.level },
            set(newVal) { this.$emit('update:level', newVal) }
        },
    },
    async mounted() {
        await this.$axios.$get('/api/v1/level_lists')
            .then(res => {
                this.levelItem = res
            })
            .catch(err => {
                console.log(err)
            })
    },
}

</script>