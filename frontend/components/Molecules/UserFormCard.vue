<template>
    <v-container
        fluid class="mt-16"
    >

        <v-row
            align="center"
            justify="center"
            class="pb-8"
        >
            <v-col
                cols="12"
                class="my-8 text-center"
            >
                <h1 class="text-h5 font-weight-bold">
                    {{ switchTitle }}
                </h1>
            </v-col>
            <v-card
                flat
                width="80%"
                max-width="320"
                color="transparent"
            >
                <!-- コンテンツを差し込むスロット -->
                <slot name="user-form-card-content" />
            </v-card>
        </v-row>
        <!-- </v-card> -->
    </v-container>
</template>

<script>

export default {
    data() {
        return {
            pageTitle: '会員登録'
        }
    },
    computed: {
        switchTitle() {
            const pageTitle = this.$route.name === 'auth-signin' ? 'ログイン' : '会員登録'
            return pageTitle
        }
    }
}
</script>