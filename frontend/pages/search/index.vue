<template>
    <v-container>
        <v-card>
            <v-toolbar
                flat
                color="primary"
                dark
            >
                <v-toolbar-title>検索</v-toolbar-title>

                <v-spacer></v-spacer>

                <template #extension>
                    <v-tabs
                        v-model="tabName"
                        fixed-tabs
                        icons-and-text
                    >
                        <div
                            v-for="(tab, i) in tabs"
                            :key="i"
                        >
                            <v-tab
                                :href="`#${tab.name}`"
                                class="pb-2"
                            >
                                {{ tab.name }}
                                <v-icon dense>{{ tab.icon }}</v-icon>
                            </v-tab>
                        </div>
                    </v-tabs>
                </template>
            </v-toolbar>
            <v-tabs-items v-model="tabName">
                <v-tab-item
                    value="練習メニュー"
                >
                    <SearchArticle />
                </v-tab-item>
                <v-tab-item
                    value="ユーザー"
                >
                    <SearchUser />
                </v-tab-item>
            </v-tabs-items>
        </v-card>
    </v-container>
</template>

<script>

import SearchArticle from '~/components/Organisms/Search/SearchArticle.vue'
import SearchUser from '~/components/Organisms/Search/SearchUser.vue'

export default {
    name: 'Search',
    components: {
        SearchArticle,
        SearchUser,
        },
    data () {
        return {
            tabName: '練習メニュー',
            tabs: [
                {name: '練習メニュー', icon: 'mdi-note'},
                {name: 'ユーザー', icon: 'mdi-account-multiple'},
            ],
        }
    },
    head(){
        return {
            title: 'Search Page',
        }
    },
}
</script>

