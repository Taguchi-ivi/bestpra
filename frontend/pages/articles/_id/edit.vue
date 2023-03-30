<template>
    <div>
        <div v-if="error">
            <ErrorCard
                title="存在しない練習メニュです"
                message="404 not found"
            />
        </div>
        <div v-else>
            <v-container>
                <MainTitle title="練習メニュ編集" />
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
                        <ArticleTag
                            v-model="chips"
                            :tags="tag_list"
                        />
                    </v-card>
                    <div
                        class="mt-5 d-flex justify-end"
                    >
                        <v-btn
                            :disabled="!isValid || loading"
                            :loading="loading"
                            color="primary"
                            class="white--text"
                            @click="updateArticle"
                        >
                            編集を保存
                        </v-btn>
                    </div>
                </v-form>
            </v-container>
        </div>
    </div>
</template>

<script>
import ErrorCard from '~/components/Molecules/ErrorCard.vue'
import MainTitle from '~/components/Atom/App/AppMainTitle.vue'
import ArticleTitle from '~/components/Atom/Article/ArticleTitle.vue'
import ArticleLevel from '~/components/Atom/Article/ArticleLevel.vue'
import ArticleTag from '~/components/Atom/Article/ArticleTag.vue'

export default {
    name: 'ArticleEdit',
    components: {
        MainTitle,
        ArticleTitle,
        ArticleLevel,
        ArticleTag,
        ErrorCard
    },
    async asyncData({ $axios,store, params  }) {
        const res = await $axios.$get('/api/v1/articles/' + params.id + '/edit')
        if(res === 'bad_request') {
            store.dispatch('modules/toast/getToast', {
                        status: true,
                        msg: '存在しない練習メニュです',
                        color: 'error'
                    })
            return {
                error: true
            }
        }
        // nameだけの配列に変更
        const tagList = res.tag_list.map(item => item.name)
        return {
            level: {
                id: res.level_list_id,
                name: '',
            },
            text: res.content,
            title: res.title,
            imageUrl: res.image.url,
            tag_list: tagList
        }
    },
    data() {
        return {
            isValid: false,
            level: {},
            text: '',
            title: '',
            imageUrl: '',
            chips: [],
            selectFile: [],
            loading: false,
            error: false,
            tag_list: [],
            deleteFlg : false,
            fileChangeFlg: false,
        }
    },
    head(){
        return {
            title: 'Article Edit Page',
        }
    },
    methods: {
        fileClick() {
            // preview作成
            this.imageUrl = window.URL.createObjectURL(this.selectFile)
            this.fileChangeFlg = true
        },
        deleteView() {
            this.imageUrl = ''
            this.deleteFlg = true
            URL.revokeObjectURL(this.imageUrl)
        },
        // async updateArticle() {
        async updateArticle() {
            if(!this.isValid || !this.text) {
                this.$vuetify.goTo(0)
                return this.dispatchToast({
                        status: true,
                        msg: 'タイトル・ラベル・内容は必須です',
                        color: 'error'
                })
            }
            this.loading = true

            const formData = new FormData()
            formData.append('article[title]', this.title)
            formData.append('article[level]', this.level.id)
            formData.append('article[content]', this.text)
            if (this.deleteFlg) formData.append('article[image]', this.selectFile)
            if (this.fileChangeFlg) formData.append('article[image]', this.selectFile)
            const appendChips = this.chips.length === 0 ? this.tag_list : this.chips
            formData.append('article[tag_list]', appendChips)

            await this.$axios.$patch('/api/v1/articles/' + this.$route.params.id, formData)
                .then((res) => {
                    this.$router.push('/articles/' + res.id)
                    this.$my.dispatchToast(true, '素敵な練習メニュをありがとう!!', 'success')
                })
                .catch((err) => {
                    console.log(err)
                    this.$my.dispatchToast(true, '更新に失敗しました', 'error')
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