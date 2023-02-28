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
                <div v-if="!imageUrl">
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
                        :src="imageUrl"
                        contain
                        max-height="400"
                    >
                    </v-img>
                    <!-- <AppImg
                        :img-url="imageUrl"
                    /> -->
                </div>
                <div class="mt-8"></div>
                <ArticleTitle
                    :title.sync="title"
                />
                <ArticleLevel
                    :level.sync="level"
                />
                <!-- :level-item="levelItem" -->
                <client-only>
                    <!-- <Ckeditor v-model="text" /> -->
                    <Ckeditor :text.sync="text" />
                </client-only>
                <pre>
                    {{ text }}
                </pre>
                <ArticleTag
                    :chips.sync="chips"
                />
            </v-card>
            <div
                class="mt-5 d-flex justify-end"
            >
                <v-btn
                    :disabled="!valid"
                    color="indigo"
                    dark
                    @click="createArticle"
                    :loading="loading"
                >
                    投稿
                </v-btn>
            </div>
        </v-form>
    </v-container>
</template>

<script>
import MainTitle from '~/components/Atom/App/AppMainTitle.vue'
import ArticleTitle from '~/components/Atom/Article/ArcielsTitle.vue'
import ArticleLevel from '~/components/Atom/Article/ArticleLevel.vue'
import ArticleTag from '~/components/Atom/Article/ArticleTag.vue'
// import AppImg from '~/components/Atom/App/AppNoImg.vue'

export default {
    name: 'ArticleCreate',
    components: {
        MainTitle,
        ArticleTitle,
        ArticleLevel,
        ArticleTag,
        // AppImg,
    },
    // async asyncData({ $axios }) {
    //     const res = await $axios.$get('/api/v1/mst_lists')
    //     // console.log(res)
    //     return {
    //         levels: res,
    //     }
    // },
    data() {
        return {
            valid: true,
            level: '',
            text: '',
            title: '',
            imageUrl: '',
            chips: '',
            selectFile: [],
            // selectItem: '',
            // // levels: [
            // //     { label: 'all', level_id: 1},
            // //     { label: '小学生', level_id: 1},
            // //     { label: '中学生', level_id: 1},
            // // ],
            // text: '<p>内容を入力してください<strong>(範囲選択でテキストを変更できます)</strong></p>',
            // chips: ['Programming', 'Playing video games', 'Watching movies', 'Sleeping'],
            // items: ['Streaming', 'Eating'],
            loading: false,
        }
    },
    methods: {
        fileClick() {
            // const thisFile = this.selectFile
            // console.log(this.selectFile)
            this.imageUrl = window.URL.createObjectURL(this.selectFile)
        },
        deleteView() {
            this.imageUrl = ''
            URL.revokeObjectURL(this.imageUrl)
        },
        fixText(text) {
            // TODO xss対策
            // ① CKEditorで入力されたリッチテキストをDOMPurifyでサニタイズする
            // ② Railsでsanitizeメソッドやsanitize_helperメソッドを使ってリッチテキストをサニタイズする
            // ③ Nuxtでv-htmlディレクティブを使わずにリッチテキストを表示するか、v-htmlディレクティブを使う場合はDOMPurifyでサニタイズする
            return text.replace(/[&<"']/g, (match) => {
                switch (match) {
                    case "&":
                        return "&amp;";
                    case "<":
                        return "&lt;";
                    case '"':
                        return "&quot;";
                    case "'":
                        return "&#039;";
                }
            })
        },
        // async createArticle() {
            async createArticle() {
            this.loading = true
            const formData = new FormData()
            // formData.append('article[user_id]', this.$auth.user.id)
            formData.append('article[title]', this.title)
            formData.append('article[content]', this.text)
            formData.append('article[image]', this.selectFile)
            formData.append('article[level_list_id]', this.level.id)

            // console.log('postデータ確認', formData)
            await this.$axios.$post('/api/v1/articles', formData )
                .then((res) => {
                    console.log('resです', res)
                    // TODO tagを追加する
                    // if(this.chips) {
                    //     console.log(this.item)
                    // }
                    // console.log('tagデータ', this.chips)
                    this.$store.dispatch('modules/toast/getToast', {
                        status: true,
                        msg: '素敵な練習メニュをありがとう!!',
                        color: 'success',
                    })
                    this.$router.push('/articles/' + res.id)
                })
                .catch((err) => {
                    console.log(err)
                    this.$store.dispatch('modules/toast/getToast', {
                        status: true,
                        msg: '新規作成に失敗しました',
                        color: 'error'
                    })
                })
            this.loading = false
        }
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