<template>
    <div
        class="d-flex justify-start mb-6"
    >
        <v-img
            :src="soccerBallImg"
            max-width="30"
        />
        <h2 class="ml-3">{{ currentTitle }}一覧</h2>
    </div>
</template>

<script>
import soccerBallImg from '~/assets/img/ball/soccer-ball.png'

export default {
    data() {
        return {
            soccerBallImg,
            currentTitle: this.title
        }
    },
    props: {
        title: {
            type: String,
            default: ''
        }
    },
    methods: {
            },
}
</script>