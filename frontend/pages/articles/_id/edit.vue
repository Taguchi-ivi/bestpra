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
                        <!-- <pre>
                            {{ text }}
                        </pre> -->
                        <ArticleTag
                            :chips.sync="chips"
                        />
                    </v-card>
                    <div
                        class="mt-5 d-flex justify-end"
                    >
                        <v-btn
                            :disabled="!valid"
                            color="primary"
                            dark
                            @click="updateArticle"
                            :loading="loading"
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
import ArticleTitle from '~/components/Atom/Article/ArcielsTitle.vue'
import ArticleLevel from '~/components/Atom/Article/ArticleLevel.vue'
import ArticleTag from '~/components/Atom/Article/ArticleTag.vue'
// import AppImg from '~/components/Atom/App/AppNoImg.vue'

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
        return {
            level: {
                id: res.level_list_id,
                name: '',
            },
            text: res.content,
            title: res.title,
            imageUrl: res.image.url,
        }
    },
    data() {
        return {
            valid: true,
            level: {},
            text: '',
            title: '',
            imageUrl: '',
            chips: '',
            selectFile: [],
            loading: false,
            error: false,
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
        async updateArticle() {
            this.loading = true
            const formData = new FormData()
            formData.append('article[title]', this.title)
            formData.append('article[level]', this.level.id)
            formData.append('article[content]', this.text)
            formData.append('article[image]', this.selectFile)
            // formData.append('chips', this.chips)
            await this.$axios.$patch('/api/v1/articles/' + this.$route.params.id, formData)
                .then((res) => {
                    console.log(res)
                    this.$router.push('/articles/' + res.id)
                    this.$store.dispatch('modules/toast/getToast', {
                        status: true,
                        msg: '素敵な練習メニュをありがとう!!',
                        color: 'success',
                    })
                })
                .catch((err) => {
                    console.log(err)
                    this.$store.dispatch('modules/toast/getToast', {
                        status: true,
                        msg: '更新に失敗しました',
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