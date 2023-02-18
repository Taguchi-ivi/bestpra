<template>
    <v-container>
        <v-card
            width="100%"
            class="mx-auto pa-5"
            elevation="2"
        >
            <NoImg />
            <v-card
                width="80%"
                flat
                color="transparent"
                class="mx-auto"
            >
                <div class="d-flex justify-end">
                    <v-btn
                        icon
                    >
                        <v-icon
                            size="30"
                        >
                            mdi-heart-outline
                        </v-icon>
                    </v-btn>

                    <v-menu
                        app
                        offset-x
                        offset-y
                        max-width="300"
                    >
                        <template
                            #activator="{ on }"
                        >
                            <v-btn
                                icon
                                v-on="on"
                            >
                                <v-icon size="25">
                                    mdi-dots-vertical
                                </v-icon>
                            </v-btn>
                        </template>
                        <v-list
                            dense
                        >
                            <v-subheader>
                                練習メニュー
                            </v-subheader>
                            <v-list-item
                                to="/articles/1/edit"
                            >
                                <v-list-item-icon
                                    class="mr-2"
                                >
                                    <v-icon size="22">
                                        mdi-pencil
                                    </v-icon>
                                </v-list-item-icon>
                                <v-list-item-title>
                                    編集する
                                </v-list-item-title>
                            </v-list-item>
                            <!-- <v-divider /> -->
                            <v-list-item>
                                <v-list-item-icon
                                    class="mr-2"
                                >
                                    <v-icon size="22">
                                        mdi-trash-can-outline
                                    </v-icon>
                                </v-list-item-icon>
                                <v-list-item-title>
                                    削除する
                                </v-list-item-title>
                            </v-list-item>
                        </v-list>
                    </v-menu>
                </div>
                <h1 class="mt-5 text-center">タイトルを表示</h1>
                <UserCardTag />
                <p class="ml-2">this.name</p>
                <div
                    class="d-flex mt-5"
                >
                    <p>作成日:2023/02/11</p>
                    <p class="ml-3">更新日:2023/02/11</p>
                </div>
                <!-- <client-only>
                    <Ckeditor v-model="text" />
                </client-only> -->
                <div
                    class="mt-5"
                >
                    {{ text }}
                </div>
            </v-card>
        </v-card>
        <v-card class="mt-8 pa-3">
            <MainTitle title="Comment" />
                <div v-if="comment">
                    <CardComment />
                </div>
                <div v-else>
                    <p class="text-center">コメントを投稿しよう!!</p>
                </div>
                <v-card
                    flat
                    color="transparent"
                    width="80%"
                    class="ml-auto"
                >
                    <v-textarea
                        outlined
                        label="Comment"
                        color="indigo"
                        class="mt-5"
                    >
                    </v-textarea>
                    <div class="text-right">
                        <v-btn
                            color=indigo
                            dark
                        >
                            コメント
                        </v-btn>
                    </div>
                </v-card>
        </v-card>
    </v-container>
</template>

<script>

import NoImg from '~/components/Atom/App/AppNoImg.vue'
import UserCardTag from '~/components/Molecules/UserCardTag.vue'
import MainTitle from '~/components/Atom/App/AppMainTitle.vue'
import CardComment from '~/components/Organisms/Card/CardComment.vue'

export default {
    // components: {
    //     Ckeditor,
    // },
    components: {
        NoImg,
        UserCardTag,
        MainTitle,
        CardComment,
    },
    data() {
        return {
            title: '',
            image: '',
            text: 'hello world',
            comment: 'a',
        }
    },
    methods: {
    },
};
</script>