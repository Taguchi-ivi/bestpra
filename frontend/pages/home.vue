<template>
    <v-container
        fluid
    >
        <v-row>
            <v-col
                cols="12" sm="4" md="3" lg="3" xl="3"
                :class="$vuetify.breakpoint.xs ? '' : 'toc-view'"
            >
                <v-list
                    rounded
                    color="transparent"
                    max-width="250"
                    :class="$vuetify.breakpoint.xs ? 'mx-auto' : ''"
                >
                    <v-list-item-group
                        v-model="model"
                        mandatory
                        color="primary"
                    >
                        <v-list-item
                            v-for="(item, i) in items"
                            :key="i"
                            :to="item.path" nuxt
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
                cols="12" sm="8" md="9" lg="9" xl="9"
            >
                <div v-if="loading">
                    <TheLoading />
                </div>
                <div v-else>
                    <nuxt-child />

                </div>
            </v-col>
        </v-row>
    </v-container>
</template>


<script>
import TheLoading from '~/components/Organisms/Application/TheLoading.vue'

export default {
    name: 'ClientHome',
    components: {
        TheLoading
    },
    middleware ({ route, redirect }) {
        if(route.name === 'home') return redirect('/home/all')
    },
    data() {
        return {
            users: {},
            loading: true,
            items: [
                {
                    icon: 'mdi-note',
                    text: '練習メニュー',
                    path: '/home/all'
                },
                {
                    icon: 'mdi-book-account',
                    text: 'フォロー中',
                    path: '/home/following'
                },
            ],
            model: 0,
        }
    },
    head(){
        return {
            title: 'Home Page',
        }
    },
    created() {
        this.loading = false
    },
}
</script>