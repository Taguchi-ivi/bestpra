<template>
    <div
        class="d-flex justify-start ml-3 my-6"
    >
        <v-img
            :src="soccerBallImg"
            max-width="30"
        />
        <div
            :class="$vuetify.breakpoint.xs ? 'text-subtitle-1' : 'text-h5'"
            class="ml-3 font-weight-bold"
        >
            {{ currentTitle }}
        </div>
    </div>
</template>

<script>
import soccerBallImg from '~/assets/img/ball/soccer-ball.png'

export default {
    props: {
        title: {
            type: String,
            default: ''
        }
    },
    data() {
        return {
            soccerBallImg,
            currentTitle: this.title
        }
    },
    methods: {
    },
}
</script>