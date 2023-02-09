<template>
    <v-container>
        <v-card>
            <v-toolbar
                flat
                class="indigo"
                dark
            >
                <v-icon>mdi-magnify</v-icon>
                <v-toolbar-title>検索</v-toolbar-title>

                <v-spacer></v-spacer>

                <template #extension>
                    <v-tabs
                        v-model="tabs"
                        fixed-tabs
                    >
                    <v-tabs-slider></v-tabs-slider>
                        <v-tab
                            href="#mobile-tabs-5-1"
                            class="indigo"
                        >
                            <v-icon>mdi-note</v-icon>
                        </v-tab>

                        <v-tab
                            href="#mobile-tabs-5-2"
                            class="indigo"
                        >
                            <v-icon>mdi-book-open-blank-variant</v-icon>
                        </v-tab>

                        <v-tab
                            href="#mobile-tabs-5-3"
                            class="indigo"
                        >
                            <v-icon>mdi-account-multiple</v-icon>
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
                    <v-card flat>
                        <v-card-text>{{ text  }}</v-card-text>
                    </v-card>
                    <MainTitle title="hello"/>
                    <CardArticle />
                    <CardNote />
                    <CardUser />
                    <MarginBottom />
                </v-tab-item>
            </v-tabs-items>
        </v-card>
        <PageTop />
    </v-container>
</template>

<script>

import MainTitle from '~/components/Atom/MainTitle.vue'
import CardArticle from '~/components/Atom/Card/CardArticle.vue'
import CardNote from '~/components/Atom/Card/CardNote.vue'
import CardUser from '~/components/Atom/Card/CardUser.vue'
import MarginBottom from '~/components/Atom/margin/marginBottom.vue'
import PageTop from '~/components/Atom/PageTop.vue'

export default {
    components: {
            MainTitle,
            CardArticle,
            CardNote,
            CardUser,
            MarginBottom,
            PageTop
        },
    data () {
        return {
            tabs: null,
            text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
        }
    },
}
</script>

