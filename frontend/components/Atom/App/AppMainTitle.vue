<template>
    <div
        class="d-flex justify-start ml-3 my-6"
    >
        <v-img
            :src="soccerBallImg"
            max-width="30"
        />
        <h2 class="ml-3">{{ currentTitle }}</h2>
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