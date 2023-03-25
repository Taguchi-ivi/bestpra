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
                <v-card-text>
                    <v-btn
                        v-for="icon in icons"
                        :key="icon.name "
                        :class="$vuetify.breakpoint.xs ? 'mx-1' : 'mx-4'"
                        icon
                        :to="icon.path" nuxt
                    >
                        <v-icon size="24px">
                            {{ icon.name }}
                        </v-icon>
                    </v-btn>
                </v-card-text>

                <v-divider></v-divider>

                <v-card-text class="white--text">
                <!-- {{ new Date().getFullYear() }} — <strong>Vuetify</strong> -->
                <strong>&copy;portfolio | k.t</strong>
                </v-card-text>
            </v-card>
        </v-footer>
    </div>
</template>

<script>

export default {
    data() {
        return {
            icons: [
                {name: 'mdi-home', path: '/home/all'},
                {name: 'mdi-account-cog', path: `/users/edit`},
                {name: 'mdi-magnify', path: '/search'},
                {name: 'mdi-pencil', path: '/articles/new'},
            ],
            items: [
                'default',
                'absolute',
                'fixed',
            ],
            padless: false,
            variant: 'default',
            drawer: false,
            group: null,
        }
    }
}
</script>