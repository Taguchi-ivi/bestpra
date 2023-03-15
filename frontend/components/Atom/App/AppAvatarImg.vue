<template>
    <div>
        <div v-if="avatarUrl">
            <v-avatar
                :size="$vuetify.breakpoint.xs ? xsSize : size"
            >
                <img
                    :src="avatarUrl"
                    alt="avatar"
                >
            </v-avatar>
        </div>
        <div v-else>
            <v-avatar
                class="align-self-center"
                :size="$vuetify.breakpoint.xs ? xsSize : size"
            >
                <v-icon
                    :size="$vuetify.breakpoint.xs ? xsSize : size"
                >
                    mdi-account-circle
                </v-icon>
            </v-avatar>
        </div>
    </div>
</template>

<script>

export default {
    props: {
        // sizeの調整はAvatar-switch-componentsも修正する
        size: {
            type: Number,
            default: 40
        },
        xsSize: {
            type: Number,
            default: 30
        },
        avatarUrl: {
            type: String,
            default: ''
        }
    },
}
</script>