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
                <v-card-title>
                    this.title
                </v-card-title>
                <v-card-subtitle>
                    作成日: 2023/02/06
                </v-card-subtitle>
            </v-card>
        </v-col>
    </v-row>
</template>