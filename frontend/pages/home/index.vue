<template>
    <v-container
        fluid
    >
        <v-row>
            <v-col
                cols="3"
                class="toc-view"
            >
                <v-list
                    rounded
                    color="transparent"
                    max-width="250"
                >
                    <v-list-item-group
                        v-model="model"
                        color="primary"
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
                        {{ model }}
                    </v-list-item-group>
                </v-list>
            </v-col>
            <v-col
                cols="9"
            >
                <div v-if="loading">
                    <TheLoading />
                </div>
                <div v-else>

                    <MainTitle
                        title="練習メニュー"
                    />
                    <CardArticleAll />
                    <MainTitle
                        title="タグ"
                    />
                    <CardTag />
                </div>
            </v-col>
        </v-row>
    </v-container>
</template>


<script>
import MainTitle from '~/components/Atom/App/AppMainTitle.vue'
import CardArticleAll from '~/components/Organisms/Card/CardArticleAll.vue'
import CardTag from '~/components/Organisms/Card/CardTag.vue'
import TheLoading from '~/components/Organisms/Application/TheLoading.vue'

export default {
    name: 'ClientHome',
    // middleware: 'get-article-current',
    // middleware: ['before-login-user'],
    components: {
        MainTitle,
        CardArticleAll,
        CardTag,
        TheLoading
    },
    // middleware: ['authentication'],
    data() {
        return {
            users: {},
            loading: true,
            items: [
                {
                    icon: 'mdi-note',
                    text: '練習メニュー',
                },
                {
                    icon: 'mdi-book-open-blank-variant',
                    text: '練習ノート',
                },
                {
                    icon: 'mdi-account-multiple',
                    text: 'ユーザー',
                },
            ],
            model: 1,
        }
    },
    created() {
        this.loading = false
    },
}
</script>