<template>
    <v-combobox
        v-model="setChips"
        :items="items"
        item-text="name"
        item-value="id"
        class="mt-10"
        return-object
        chips
        clearable
        label="タグを選択(3つまで)"
        multiple
        prepend-icon="mdi-tag-multiple"
        solo
    >
        <template #selection="{ attrs, item, select, selected }">
            <v-chip
                v-bind="attrs"
                :input-value="selected"
                text-color="primary"
                close
                @click="select"
                @click:close="remove(item)"
                return-object
            >
                <!-- <strong>{{ item.name }}</strong>&nbsp;
                <span>(interest)</span> -->
                <strong>{{ item.name }}</strong>
            </v-chip>
        </template>
    </v-combobox>
</template>

<script>
export default {
    // props: {
    //     chips: {
    //         type: Array,
    //         default: () => [],
    //     }
    // },
    data() {
        return {
            // TODO マスタデータ追加&&存在するお項目以外は選べないようにする
            // TODO chipsの値は受け取る
            // TODO 選択肢の色を変える
            // chips: ['Programming', 'Playing video games', 'Watching movies', 'Sleeping'],
            items: [],
            chips: [],
            loading: false,
        }
    },
    async mounted() {
        await this.$axios.$get('/api/v1/tag_lists')
            .then(res => {
                // console.log('tag_listのindexデータ', res)
                this.items = res
            })
            .catch(err => {
                console.log(err)
            })
    },
    computed: {
        setChips: {
            get() { return this.chips },
            set(newVal) { this.$emit('update:chips', newVal) }
        },
    },
    methods: {
        remove (item) {
            this.chips.splice(this.chips.indexOf(item), 1)
        },
    },
}
</script>