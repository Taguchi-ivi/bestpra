<template>
    <div
        class="pa-8"
    >
        <v-card
            class="mx-auto pa-5"
            max-width="600px"
        >
            <v-card-title>
                <h1>{{ title }}</h1>
            </v-card-title>
            <v-card-text>
                <p>{{ message }}</p>
            </v-card-text>
            <div class="text-center">
                <v-btn
                    @click="$router.push('/home')"
                    icon
                >
                    <v-icon>
                        mdi-home
                    </v-icon>
                    homeへ
                </v-btn>
            </div>
        </v-card>
    </div>
</template>

<script>
export default {
    props: {
        title: {
            type: String,
            required: true
        },
        message: {
            type: String,
            required: true
        }
    }
}
</script>