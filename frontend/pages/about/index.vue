<template>
    <div>
        <div class="main">
            <v-img
                :aspect-ratio="2/1"
                alt="aboutImg"
                :src="aboutImgMain"
            >
            </v-img>
            <div class="main-container">
                <div
                    class="my-12"
                >
                    <span>
                        あなたにあった練習が見つかる<br />
                        それがbestpra
                    </span>
                </div>
                <div
                    class="main-button text-center mobile-and-down"
                >
                    <v-row
                        align="center"
                        justify="space-around"
                    >
                        <v-btn
                            v-if="!$auth.loggedIn()"
                            :loading="guestLoading"
                            color="accent"
                            class="px-8"
                            elevation="13"
                            rounded
                            :small="$vuetify.breakpoint.xs ? true : false"
                            @click="guestLogin"
                        >
                            ゲストログイン
                            <v-icon right>
                                mdi-account-arrow-right
                            </v-icon>
                        </v-btn>
                        <v-btn
                            v-if="$auth.loggedIn()"
                            color="accent"
                            class="pl-8"
                            elevation="13"
                            rounded
                            :small="$vuetify.breakpoint.xs ? true : false"
                            to="/home/all" nuxt
                        >
                            練習メニュを開く
                            <v-icon right>
                                mdi-book-open-variant
                            </v-icon>
                        </v-btn>
                    </v-row>
                </div>
            </div>
        </div>
        <v-container
            class="mb-30"
        >
            <div class="about pt-10 mb-10">
                <h2 class="subtitle mb-5">bestpraとは</h2>
                <v-row class="about-container d-flex justify-space-between">
                    <v-col
                        cols="12" sm="4" md="4" lg="4" xl="4"
                    >
                        <v-row>
                            <v-col>
                                <v-img
                                    class="mb-5"
                                    contain
                                    max-height="auto"
                                    :width="$vuetify.breakpoint.xs ? 100 :150"
                                    :src="aboutImg01"
                                    alt="サッカー風景"
                                >
                                </v-img>
                            </v-col>
                            <v-col>
                                <v-img
                                    contain
                                    max-height="auto"
                                    :width="$vuetify.breakpoint.xs ? 100 :150"
                                    :src="aboutImg02"
                                    alt="サッカー風景"
                                >
                                </v-img>
                            </v-col>
                        </v-row>
                    </v-col>
                    <v-col
                        cols="12" sm="4" md="4" lg="4" xl="4"
                    >
                        <div class="text-center">
                            <h3>
                                bestpraとは<br />
                                サッカーの練習メニュを<br />共有するサービスです。
                            </h3>
                            <h3 class="mt-8">
                                練習メニュを考える時間を練習に<br />
                                そんなサービスを心掛けています。
                            </h3>
                        </div>
                    </v-col>
                    <v-col
                        cols="12" sm="4" md="4" lg="4" xl="4"
                    >
                        <v-row>
                            <v-col>
                                <v-img
                                    class="mb-5 ml-auto"
                                    contain
                                    max-height="auto"
                                    :width="$vuetify.breakpoint.xs ? 80 :150"
                                    :src="aboutImg03"
                                    alt="サッカー風景"
                                >
                                </v-img>
                            </v-col>
                            <v-col>
                                <v-img
                                    class="ml-auto"
                                    contain
                                    max-height="auto"
                                    :width="$vuetify.breakpoint.xs ? 100 :150"
                                    :src="aboutImg04"
                                    alt="サッカー風景"
                                >
                                </v-img>
                            </v-col>
                        </v-row>
                    </v-col>
                </v-row>
            </div>
            <div class="example mt-5">
                <v-sheet
                    class="mx-auto"
                    max-width="800"
                >
                    <h2 class="subtitle m5-8">例えば....</h2>
                    <v-slide-group
                        show-arrows
                    >
                        <v-slide-item
                            v-for="article in articles"
                            :key="article.id"
                            class="pa-3"
                        >
                            <div
                                class="ma-3"
                            >
                                <ArticleAbout
                                    :article="article"
                                />
                            </div>
                        </v-slide-item>
                    </v-slide-group>
                </v-sheet>
            </div>
            <div class="uses">
                <h2 class="subtitle mb-8">使い方</h2>
                <v-row class="uses-container">
                    <v-col>
                        <v-stepper
                            v-model="e6"
                            vertical
                            rounded-lg
                        >
                            <v-stepper-step
                                :complete="e6 > 1"
                                step="1"
                                color="primary"
                            >
                                まずは登録しよう！
                            <small>Please singup or login</small>
                            </v-stepper-step>

                            <v-stepper-content step="1">
                                <v-img
                                    :src="loginImg"
                                    :aspect-ratio="16/9"
                                    max-width="500"
                                />
                                <v-btn
                                    color="primary"
                                    :small="$vuetify.breakpoint.xs ? true : false"
                                    to="/auth/signup" nuxt
                                >
                                    会員登録
                                </v-btn>
                                <v-btn
                                    text
                                    color="primary"
                                    :small="$vuetify.breakpoint.xs ? true : false"
                                    @click="e6 = 2"
                                >
                                    次へ
                                </v-btn>

                            </v-stepper-content>

                            <v-stepper-step
                                :complete="e6 > 2"
                                step="2"
                                color="primary"
                            >
                                自分が練習したいメニュを探そう！
                                <small>search training menu</small>
                            </v-stepper-step>

                            <v-stepper-content step="2">
                                <v-img
                                    :src="searchImg"
                                    :aspect-ratio="16/9"
                                    max-width="500"
                                />
                                <v-btn
                                    color="primary"
                                    :small="$vuetify.breakpoint.xs ? true : false"
                                    to="/search" nuxt
                                >
                                    検索ページへ
                                </v-btn>
                                <v-btn
                                    text
                                    color="primary"
                                    :small="$vuetify.breakpoint.xs ? true : false"
                                    @click="e6 = 3"
                                >
                                    次へ
                                </v-btn>
                            </v-stepper-content>

                            <v-stepper-step
                                step="3"
                                color="primary"
                            >
                                自分の練習メニュを投稿してみよう！
                                <small>post training menus</small>
                            </v-stepper-step>
                            <v-stepper-content step="3">
                                <v-img
                                    :src="articleImg"
                                    :aspect-ratio="16/9"
                                    max-width="500"
                                />
                                <v-btn
                                    color="primary"
                                    :small="$vuetify.breakpoint.xs ? true : false"
                                    to="articles/new"
                                >
                                    投稿する
                                </v-btn>
                                <v-btn
                                    text
                                    color="primary"
                                    :small="$vuetify.breakpoint.xs ? true : false"
                                    @click="e6 = 1"
                                >
                                    最初へ
                                </v-btn>
                            </v-stepper-content>
                        </v-stepper>
                    </v-col>
                </v-row>
            </div>
        </v-container>
    </div>
</template>

<script>
import aboutImgMain from '~/assets/img/about/about-main.jpg'
import aboutImg01 from '~/assets/img/about/soccer-01.svg'
import aboutImg02 from '~/assets/img/about/soccer-02.svg'
import aboutImg03 from '~/assets/img/about/soccer-03.svg'
import aboutImg04 from '~/assets/img/about/soccer-04.svg'
import loginImg from '~/assets/img/about/login-img.png'
import searchImg from '~/assets/img/about/search-img.png'
import memoImg from '~/assets/img/about/memo-img.png'
import articleImg from '~/assets/img/about/article-img.png'
import ArticleAbout from '~/components/Molecules/ArticleAbout.vue'

    export default {
        name: 'About',
        components: {
            ArticleAbout,
        },
        layout: 'beforeLogin',
        async asyncData({ $axios }) {
            const res = await $axios.$get('/api/v1/articles/article_about')
            return {
                articles: res
            }
        },
        data () {
            return {
                e6: 1,
                aboutImgMain,
                aboutImg01,
                aboutImg02,
                aboutImg03,
                aboutImg04,
                loginImg,
                searchImg,
                memoImg,
                articleImg,
                model: null,
                guestLoading: false,
            }
        },
        head(){
            return {
                title: 'About Page',
            }
        },
        methods: {
            async guestLogin() {
                this.guestLoading = true
                await this.$auth.guestUserLogin()
                this.guestLoading = false
                this.$router.push('/home/all')
            }
        }
    }
</script>

<style lang="scss" scoped>
.main {
    position: relative;

    img {
        width: 100%;
        height: 600px;
    }
    .main-container {
        position: absolute;
        max-width: 400px;
        top: 30%;
        left: 60%;
        transform: translate(-50%,-50%);
        @media only screen and (max-width: 840px) {
            left: 55%;
        }
        @media only screen and (max-width: 750px) {
            left: 50%;
        }
        @media only screen and (max-width:680px) {
            left: 45%;
        }
        @media only screen and (max-width: 600px) {
            top: 50%;
        }
        @media only screen and (max-width: 510px) {
            left: 40%;
        }

        span {
            font-size: 20px;
            font-weight: bold;
            background:linear-gradient(transparent 60%, var(--v-secondary-base) 60%);
            @media only screen and (max-width: 470px) {
                font-size: 16px;
            }
            @media only screen and (max-width: 380px) {
                font-size: 12px;
            }
        }
    }
}

.subtitle  {
    position: relative;
    padding: 1.5rem;
    text-align: center;

    &:before {
        position: absolute;
        bottom: 15px;
        left: calc(50% - 30px);
        width: 60px;
        height: 5px;
        content: '';
        border-radius: 3px;
        background-color: #B5EAEA;
    }
}

</style>