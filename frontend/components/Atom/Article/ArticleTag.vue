<template>
    <div>
        <v-combobox
            v-model="setChips"
            :items="items"
            class="mt-10"
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
                >
                    <!-- <strong>{{ item.name }}</strong>&nbsp;
                    <span>(interest)</span> -->
                    <strong>{{ item }}</strong>
                </v-chip>
            </template>
        </v-combobox>
        <!-- <p>{{ setChips }}</p> -->
    </div>
</template>

<script>
export default {
    props: {
        tags: {
            type: Array,
            default: () => [],
        }
    },
    data() {
        return {
            // TODO マスタデータ追加&&存在するお項目以外は選べないようにする
            // TODO chipsの値は受け取る
            // TODO 選択肢の色を変える
            // chips: ['Programming', 'Playing video games', 'Watching movies', 'Sleeping'],
            setChips: this.tags,
            items: [],
            chips: [],
            loading: false,
        }
    },
    computed: {
        // get,setでの子コンポーネントでのデータ参照難しいのでやめた
        // setChips: {
        //     get() { return this.chips },
        //     set(newVal) { this.$emit('update:chips', newVal) }
        // },
    },
    watch: {
        setChips(newVal) {
            this.$emit('input', newVal)
        }
    },
    async mounted() {
        await this.$axios.$get('/api/v1/tag_lists')
            .then(res => {
                // tag_listのnameだけの配列を作成する
                this.items = res.map(item => item.name)
            })
            .catch(err => {
                console.log(err)
            })
    },
    methods: {
        remove (item) {
            // console.log(item)
            // console.log(this.setChips)
            // this.chips.splice(this.chips.indexOf(item.name), 1)
            this.setChips.splice(this.setChips.indexOf(item.name), 1)
        },
    },
}
</script>