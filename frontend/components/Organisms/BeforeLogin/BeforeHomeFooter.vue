<template>
    <div class="my-16">
        <div class="footer-m my-16"></div>
        <div class="footer-m my-16"></div>
        <div class="footer-m my-16"></div>
        <v-footer
            :padless="padless"
            color="accent"
            absolute
            class="mt-16"
        >
            <v-card
                flat
                tile
                width="100%"
                class="accent text-center"
            >
                <v-card-text class="d-flex justify-center">
                    <div>
                        <nuxt-link to="/rule" class="white--text">利用規約</nuxt-link>
                    </div>
                    <div class="ml-3 white--text">
                        <nuxt-link to="/privacy_policy" class="white--text">プライパシーポリシー</nuxt-link>
                    </div>
                </v-card-text>
                <v-divider></v-divider>
                <v-card-text class="white--text">
                <!-- {{ new Date().getFullYear() }} — <strong>Vuetify</strong> -->
                <strong>&copy;2023- bestpra</strong>
                </v-card-text>
            </v-card>
        </v-footer>
    </div>
</template>
<script>
export default {
    data() {
        return {
            padless: false,
            variant: 'default',
            drawer: false,
            group: null,
        }
    }
}
</script>