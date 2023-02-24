<template>
    <v-container>
        <MainTitle title="練習メニュ作成" />
        <v-form
            ref="form"
            v-model="valid"
        >
            <v-card
                width="100%"
                class="mx-auto pa-5"
                elevation="2"
            >
                <div v-if="!image">
                    <v-file-input
                        v-model="selectFile"
                        prepend-icon="mdi-image-plus"
                        hide-input
                        @change="fileClick"
                    >
                    </v-file-input>
                    <!-- <input ref="view" type="file" @change="uploadFile"> -->
                </div>
                <div v-else class="img-active">
                    <div class="img-active-delete" @click="deleteView">
                        <v-icon
                            large
                            color="grey darken-1"
                        >
                            mdi-alpha-x-circle
                        </v-icon>
                    </div>
                    <v-img
                        :aspect-ratio="16/9"
                        :src="image"
                        contain
                        max-height="400"
                    >
                    </v-img>
                </div>
                <div>{{ image }}</div>
                <v-text-field
                    v-model="title"
                    label="タイトル"
                    required
                >
                </v-text-field>
                <v-card
                    max-width="200"
                    flat
                    color="transparent"
                    class="ml-auto"
                >
                    <v-select
                        v-model="selectItem"
                        :items="states"
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
                    >
                    </v-select>
                </v-card>
                <client-only>
                    <Ckeditor v-model="text" />
                </client-only>
                <pre>
                    {{ text }}
                </pre>
                <v-combobox
                    v-model="chips"
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
                            item-color="orange lighten-1"
                            close
                            @click="select"
                            @click:close="remove(item)"
                        >
                            <strong>{{ item }}</strong>&nbsp;
                            <span>(interest)</span>
                        </v-chip>
                    </template>
                </v-combobox>
            </v-card>
            <div
                class="mt-5 d-flex justify-end"
            >
                <v-btn
                    :disabled="!valid"
                    color="indigo"
                    dark
                    @click="submit"
                >
                    投稿
                </v-btn>
            </div>
        </v-form>
    </v-container>
</template>

<script>
// import Ckeditor from '~/components/Ckeditor.vue'
import MainTitle from '~/components/Atom/App/AppMainTitle.vue'

export default {
    // components: {
    //     Ckeditor,
    // },
    components: {
        MainTitle
    },
    data() {
        return {
            valid: true,
            title: '',
            selectFile: [],
            image: '',
            selectItem: '',
            states: [
                'all',
                '小学生',
                '中学生',
                '高校生',
                '大学生以上'
            ],
            text: 'hello world',
            chips: ['Programming', 'Playing video games', 'Watching movies', 'Sleeping'],
            items: ['Streaming', 'Eating'],
        }
    },
    methods: {
        uploadFile() {
            const file = this.$refs.view.files[0]
            // console.log(file)
            // this.image = URL.createObjectURL(file)
            this.image = window.URL.createObjectURL(file)
        },
        fileClick() {
            // const thisFile = this.selectFile
            // console.log(this.selectFile)
            this.image = window.URL.createObjectURL(this.selectFile)
        },
        remove (item) {
            this.chips.splice(this.chips.indexOf(item), 1)
        },
        submit() {

        },
        deleteView() {
            this.image = ''
            URL.revokeObjectURL(this.image)
        },
    },
};
</script>

<style lang="scss" scoped>
.img-active {
    position: relative;

    &-delete {
        position: absolute;
        top: -10px;
        right: -10px;
        z-index: 100;
    }
}

</style>