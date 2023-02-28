<template>
    <!-- TODO コンポーネント化 -->
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
            color="indigo"
            item-color="indigo"
            menu-props="auto"
            label="対象者を選択"
            hide-details
            prepend-icon="mdi-label"
            single-line
            chips
            placeholder="対象者を選択してください"
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
            levelItem: []
        }
    },
    async mounted() {
        await this.$axios.$get('/api/v1/level_lists')
            .then(res => {
                console.log('level_lsitのindexデータ', res)
                this.levelItem = res
            })
            .catch(err => {
                console.log(err)
            })
    },
    computed: {
        setLevel: {
            get() { return this.level },
            set(newVal) { this.$emit('update:level', newVal) }
        },
    }
}

</script>