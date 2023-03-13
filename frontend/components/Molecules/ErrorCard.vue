<template>
    <div
        class="pa-8"
    >
        <v-card
            class="mx-auto pa-5"
            max-width="600px"
        >
            <v-card-title>
                <p
                    class="text-sm-body-2 font-weight-bold"
                >
                    {{ title }}
                </p>
            </v-card-title>
            <v-card-text>
                <p>{{ message }}</p>
            </v-card-text>
            <div v-if="content === 'home'">
                <div class="text-center">
                    <v-btn
                        icon
                        @click="$router.push('/home/all')"
                    >
                        <v-icon>
                            mdi-home
                        </v-icon>
                        homeへ
                    </v-btn>
                </div>
            </div>
        </v-card>
    </div>
</template>

<script>

export default {
    props: {
        title: {
            type: String,
            default: ''
        },
        message: {
            type: String,
            default: ''
        },
        content: {
            type: String,
            default: 'home'
        }
    }
}
</script>