<template>
    <v-combobox
        v-model="setChips"
        :items="items"
        chips
        clearable
        label="タグを選択"
        color="indigo"
        multiple
        prepend-icon="mdi-tag-multiple"
        solo
    >
        <template #selection="{ attrs, item, select, selected }">
            <v-chip
                v-bind="attrs"
                :input-value="selected"
                text-color="indigo"
                close
                @click="select"
                @click:close="remove(item)"
                return-object
            >
                <strong>{{ item }}</strong>&nbsp;
                <span>(interest)</span>
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
            chips: [],
            items: ['Programming', 'Playing video games', 'Watching movies', 'Sleeping','Streaming', 'Eating'],
            loading: false,
        }
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