<template>
    <v-container>
        <v-card>
            <v-toolbar
                flat
                color="primary"
                dark
            >
                <!-- <v-icon>mdi-magnify</v-icon> -->
                <v-toolbar-title>検索</v-toolbar-title>

                <v-spacer></v-spacer>

                <template #extension>
                    <v-tabs
                        v-model="tabs"
                        fixed-tabs
                        icons-and-text
                    >
                    <v-tabs-slider></v-tabs-slider>
                        <v-tab
                            href="#mobile-tabs-5-1"
                            class="pb-2"
                        >
                            練習メニュ
                            <v-icon dense>mdi-note</v-icon>
                        </v-tab>

                        <v-tab
                            href="#mobile-tabs-5-2"
                            class="pb-2"
                        >
                            タグ
                            <v-icon dense>mdi-tag</v-icon>
                        </v-tab>

                        <v-tab
                            href="#mobile-tabs-5-3"
                            class="pb-2"
                        >
                            対象者
                            <v-icon dense>mdi-label</v-icon>
                        </v-tab>

                        <v-tab
                            href="#mobile-tabs-5-4"
                            class="pb-2"
                        >
                            ユーザー
                            <v-icon dense>mdi-account-multiple</v-icon>
                        </v-tab>
                        </v-tabs>
                </template>
            </v-toolbar>
            <v-tabs-items v-model="tabs">
                <!-- 動的なcomponents -->
                <v-tab-item
                    v-for="i in 3"
                    :key="i"
                    :value="'mobile-tabs-5-' + i"
                >
                    <!-- <v-card flat>
                        <v-card-text>{{ text  }}</v-card-text>
                    </v-card> -->
                        <!-- <v-text-field
                            v-model="searchText"
                            solo
                            label="検索!!"
                            clearable
                            append-outer-icon="mdi-magnify"
                            class="mt-8"
                        >
                        </v-text-field> -->
                        <v-card
                            max-width="80%"
                            class="mx-auto"
                            color="transparent"
                            flat
                        >
                            <v-text-field
                                label="検索!!"
                                solo
                                prepend-inner-icon="mdi-magnify"
                                class="mx-auto mt-8"
                            >
                            </v-text-field>
                        </v-card>
                    <MainTitle title="hello"/>
                    <CardArticle />
                    <CardTag />
                    <CardUser />
                    <MarginBottom />
                </v-tab-item>
            </v-tabs-items>
        </v-card>
        <PageTop />
    </v-container>
</template>

<script>

import MainTitle from '~/components/Atom/App/AppMainTitle.vue'
import CardArticle from '~/components/Organisms/Card/CardArticle.vue'
import CardTag from '~/components/Organisms/Card/CardTag.vue'
import CardUser from '~/components/Organisms/Card/CardUser.vue'
import MarginBottom from '~/components/Atom/margin/marginBottom.vue'
import PageTop from '~/components/Atom/App/AppPageTop.vue'

export default {
    components: {
            MainTitle,
            CardArticle,
            CardTag,
            CardUser,
            MarginBottom,
            PageTop
        },
    data () {
        return {
            tabs: null,
            searchText: 'hello!!',
            text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
        }
    },
}
</script>

