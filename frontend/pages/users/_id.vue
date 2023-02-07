<template>
    <div>
        <div
            class="grey lighten-1"
        >
            <v-row
                no-gutters
                class="pa-10 mx-auto"
            >
                <v-col
                    cols="2"
                >
                    <v-avatar color="indigo">
                        <v-icon dark>
                            mdi-account-circle
                        </v-icon>
                    </v-avatar>
                    <p>{{ name }}</p>
                </v-col>
                <v-col
                    cols="7"
                >
                    {{ introduction }}
                </v-col>
                <v-col
                    cols="3"
                >
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
                                <v-icon size="20">
                                    mdi-cog-outline
                                </v-icon>
                            </v-btn>
                        </template>
                        <v-list
                            dense
                        >
                            <v-subheader>
                                アカウント
                            </v-subheader>
                            <v-list-item
                                to="/users/edit"
                            >
                                <v-list-item-icon
                                    class="mr-2"
                                >
                                    <v-icon size="22">
                                        mdi-account-edit
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
                                        mdi-account-remove
                                    </v-icon>
                                </v-list-item-icon>
                                <v-list-item-title>
                                    削除する
                                </v-list-item-title>
                            </v-list-item>
                        </v-list>
                    </v-menu>
                </v-col>
            </v-row>
        </div>
        <v-container
            class="mt-5"
        >
            <v-row no-gutters>
                <v-col
                    cols="3"
                >
                    <v-list
                        rounded
                        color="transparent"
                        max-width="250"
                        class="toc-view"
                    >
                        <v-list-item-group
                            v-model="model"
                            color="indigo"
                        >
                            <v-list-item
                                v-for="(item, i) in items"
                                :key="i"
                            >
                            <v-list-item-icon>
                                <v-icon>
                                    {{ item.icon }}
                                </v-icon>
                            </v-list-item-icon>
                            <v-list-item-content>
                                <v-list-item-title>
                                    {{ item.text }}
                                </v-list-item-title>
                            </v-list-item-content>
                            </v-list-item>
                        </v-list-item-group>
                    </v-list>
                </v-col>
                <v-col
                    cols="9"
                >
                    <MainTitle
                        :title="tabTitle"
                    />
                    <v-row>
                        <v-col
                            v-for="n in 4"
                            :key="n"
                            class="d-flex justify-center"
                        >
                            <v-card
                                max-width="300"
                                to="/" nuxt
                                hover
                                rounded
                            >
                                <v-img
                                    src="https://cdn.vuetifyjs.com/images/cards/sunshine.jpg"
                                    height="auto"
                                >
                                </v-img>
                                <v-card-title>
                                    this.title
                                </v-card-title>
                                <v-card-subtitle>
                                    作成日: 2023/02/06
                                </v-card-subtitle>
                            </v-card>
                        </v-col>
                    </v-row>
                </v-col>
            </v-row>
        </v-container>
    </div>
</template>

<script>

import soccerBallImg from '~/assets/img/ball/soccer-ball.png'
import MainTitle from '~/components/Atom/MainTitle.vue'

export default {
    components: {
        MainTitle,
    },
    data() {
        return {
            tabTitle: 'フォロワー',
            soccerBallImg,
            on: false,
            introduction: 'testtesttesttesttesttesttesttesttesttesttesttesttesttest',
            name: 'meron',
            items: [
                {
                    icon: 'mdi-account-star',
                    text: 'フォロー',
                },
                {
                    icon: 'mdi-account-star-outline',
                    text: 'フォロワー',
                },
                {
                    icon: 'mdi-heart',
                    text: 'いいね',
                },
                {
                    icon: 'mdi-note',
                    text: '練習メニュー',
                },
                {
                    icon: 'mdi-book-open-blank-variant',
                    text: '練習ノート',
                },
            ],
            model: 1,
        }
    }
}
</script>

<style lang="scss" scoped>
.toc-view {
    position: sticky;
    top: 5rem;
    max-height: 90vh;
    // overflow: scroll;
}
</style>