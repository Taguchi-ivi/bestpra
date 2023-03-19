<template>
    <v-container>
        <MainTitle title="練習メニュ作成" />
        <v-form
            ref="form"
            v-model="isValid"
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
                </div>
                <div class="mt-8"></div>
                <ArticleTitle
                    :title.sync="title"
                />
                <ArticleLevel
                    :level.sync="level"
                />
                <client-only>
                    <Ckeditor :text.sync="text" />
                </client-only>
                <!-- <div>{{ text }}</div> -->
                <ArticleTag
                    v-model="chips"
                />
            </v-card>
            <div
                class="mt-5 text-right"
            >
                <v-btn
                    :disabled="!isValid || loading"
                    :loading="loading"
                    color="primary"
                    class="white--text"
                    @click="createArticle"
                >
                    投稿
                </v-btn>
            </div>
        </v-form>
    </v-container>
</template>

<script>
import { mapActions, mapMutations } from 'vuex'
import MainTitle from '~/components/Atom/App/AppMainTitle.vue'
import ArticleTitle from '~/components/Atom/Article/ArticleTitle.vue'
import ArticleLevel from '~/components/Atom/Article/ArticleLevel.vue'
import ArticleTag from '~/components/Atom/Article/ArticleTag.vue'

export default {
    name: 'ArticleCreate',
    components: {
        MainTitle,
        ArticleTitle,
        ArticleLevel,
        ArticleTag,
    },
    data() {
        return {
            isValid: false,
            level: {},
            title: '',
            imageUrl: '',
            chips: '',
            selectFile: [],
            text: '<p>内容を入力してください<strong>(範囲選択でテキストを変更できます)</strong></p>',
            loading: false,
        }
    },
    head(){
        return {
            title: 'Article New Page',
        }
    },
    methods: {
        ...mapActions({
            dispatchCurrentUser: 'modules/user/getCurrentUser',
        }),
        ...mapMutations({
            commitAllLike: 'modules/like/setAddAllLike',
        }),
        fileClick() {
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
        async createArticle() {
            if(!this.isValid || !this.text) {
                this.$vuetify.goTo(0)
                return this.$my.dispatchToast(true, 'タイトル・ラベル・内容は必須です', 'error')
            }
            this.loading = true
            const formData = new FormData()
            formData.append('article[title]', this.title)
            formData.append('article[content]', this.text)
            formData.append('article[image]', this.selectFile)
            formData.append('article[level_list_id]', this.level.id)

            const appendChips = this.chips.length === 0 ? [] : this.chips
            formData.append('article[tag_list]', appendChips)
            await this.$axios.$post('/api/v1/articles', formData )
                .then((res) => {
                    this.commitAllLike({
                        id: res.id,
                        likes: []
                    })
                    this.$my.dispatchToast(true, '素敵な練習メニュをありがとう!!', 'success')
                    this.$router.push('/articles/' + res.id)
                })
                .catch((err) => {
                    console.log(err)
                    this.$my.dispatchToast(true, '作成に失敗しました', 'error')
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