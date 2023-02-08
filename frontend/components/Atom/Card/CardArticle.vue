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
                <v-list-item-avatar
                    color="indigo"
                    class="ml-3"
                >
                    <v-icon dark>
                        mdi-account-circle
                    </v-icon>
                </v-list-item-avatar>
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