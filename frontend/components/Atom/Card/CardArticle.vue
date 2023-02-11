<template>
    <v-row>
        <v-col
            v-for="n in 12"
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
                <v-row
                    class="mt-2"
                >
                    <v-col
                        cols="3"
                    >
                        <v-list-item-avatar
                            color="indigo"
                            class="ml-3"
                            >
                            <v-icon dark>
                                mdi-account-circle
                            </v-icon>
                        </v-list-item-avatar>
                    </v-col>
                    <v-col
                        cols="9"
                    >
                        <div>
                            <v-chip
                                color="indigo"
                                dark
                                label
                                small
                            >
                                <v-icon left>
                                    mdi-label
                                </v-icon>
                                大学生以上
                            </v-chip>
                        </div>
                        <div class="mt-1">
                            <v-icon>
                                mdi-tag-multiple
                            </v-icon>
                            <v-chip
                                v-for="i in 2"
                                :key="i"
                                outlined
                                color="indigo"
                                class="ml-1"
                                dark
                                small
                            >
                                シュート
                            </v-chip>
                        </div>
                    </v-col>
                </v-row>
                <!-- <v-divider /> -->
                <v-card-title>
                    this.title
                </v-card-title>
                <v-card-subtitle>
                    作成日: 2023/02/06
                </v-card-subtitle>
                <div
                    class="d-flex justify-end mb-2"
                >
                    <div>
                        <v-icon>
                            mdi-heart
                        </v-icon>
                        <span class="subheading mr-2">256</span>
                    </div>
                    <div
                        class="mr-3"
                    >
                        <v-icon>
                            mdi-comment-text-outline
                        </v-icon>
                        <span class="subheading">45</span>
                    </div>
                </div>
            </v-card>
        </v-col>
    </v-row>
</template>