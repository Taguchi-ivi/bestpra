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
                <h1 class="mb-12">
                    <span>
                        あなたにあった練習が見つかる<br />
                        それがbestpra
                    </span>
                </h1>
                <div class="main-button text-center">
                    <v-row
                        align="center"
                        justify="space-around"
                    >
                        <v-btn
                            color="accent"
                            class="px-8"
                            large
                            elevation="13"
                            rounded
                            to="/auth/signup" nuxt
                        >
                            始める
                            <v-icon right>
                                mdi-account-arrow-right
                            </v-icon>
                        </v-btn>
                        <v-btn
                            color="accent"
                            class="pl-8"
                            large
                            elevation="13"
                            rounded
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
            <div class="about pt-15 mb-15">
                <h2 class="subtitle mb-8">bestpraとは</h2>
                <v-row class="about-container d-flex justify-space-between">
                    <v-col>
                        <v-img
                            class="mb-5"
                            contain
                            max-height="auto"
                            max-width="150"
                            :src="aboutImg01"
                            alt="サッカー風景"
                        >
                        </v-img>
                        <v-img
                            contain
                            max-height="auto"
                            max-width="150"
                            :src="aboutImg02"
                            alt="サッカー風景"
                        >
                        </v-img>
                    </v-col>
                    <v-col>
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
                    <v-col class="ml-auto">
                        <v-img
                            class="mb-5"
                            contain
                            max-height="auto"
                            max-width="150"
                            :src="aboutImg03"
                            alt="サッカー風景"
                        >
                        </v-img>
                        <v-img
                            contain
                            max-height="auto"
                            max-width="160"
                            :src="aboutImg04"
                            alt="サッカー風景"
                        >
                        </v-img>
                    </v-col>
                </v-row>
            </div>
            <div class="example">
                <!-- cardを複数列記するこれが一番分かりやすい -->
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
                                color="accent"
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
                                    color="secondary"
                                    to="/auth/signup" nuxt
                                >
                                    会員登録
                                </v-btn>
                                <v-btn
                                    text
                                    @click="e6 = 2"
                                >
                                    次へ
                                </v-btn>

                            </v-stepper-content>

                            <v-stepper-step
                                :complete="e6 > 2"
                                step="2"
                                color="accent"
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
                                    color="secondary"
                                    to="/search" nuxt
                                >
                                    検索ページへ
                                </v-btn>
                                <v-btn
                                    text
                                    @click="e6 = 3"
                                >
                                    次へ
                                </v-btn>
                            </v-stepper-content>

                            <!-- <v-stepper-step
                                :complete="e6 > 3"
                                step="3"
                                color="accent"
                            >
                                １日の練習スケジュールをメモしよう！
                                <small>training menus memo</small>
                            </v-stepper-step>
                            <v-stepper-content step="3">
                                <v-img
                                    :src="memoImg"
                                    :aspect-ratio="16/9"
                                    max-width="500"
                                />
                                <v-btn
                                    color="secondary"
                                    to="/home"
                                >
                                    練習メニュを投稿
                                </v-btn>
                                <v-btn
                                    text
                                    @click="e6 = 4"
                                >
                                    次へ
                                </v-btn>
                            </v-stepper-content> -->

                            <v-stepper-step step="3" color="accent">
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
                                    color="secondary"
                                    to="articles/new"
                                >
                                    投稿する
                                </v-btn>
                                <v-btn
                                    text
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

    export default {
        name: 'About',
        layout: 'beforeLogin',
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
                articleImg
            }
        },
        head(){
            return {
                title: 'About Page',
            }
        },
    }
</script>

<style lang="scss" scoped>
.main {
    position: relative;

    img {
        width: 100%;
        height: 571px;
    }
    .main-container {
        min-width: 570px;
        position: absolute;
        margin-left: 20px;
        top: 30%;
        left: 67%;
        transform: translate(-50%,-50%);

        span {
            background:linear-gradient(transparent 60%, var(--v-secondary-base) 60%);
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
        background-color: var(--v-info-base);
    }
}

</style>