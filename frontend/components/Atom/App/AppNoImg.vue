<template>
    <!-- width="100%"
    height="auto" -->
    <v-img
        :aspect-ratio="16/9"
        :src="imgUrl ? imgUrl : NoImg"
        contain
        :max-height="cardFlg ? 400 : 400"
        width="100%"
    >
    </v-img>
</template>

<script>
import NoImg from '~/assets/img/card/coming-soon.jpg'
export default {
    props: {
        imgUrl: {
            type: String,
            default: ''
        },
        cardFlg: {
            type: Boolean,
            default: false
        }
    },
    data() {
        return {
            NoImg
        }
    }
}
</script>