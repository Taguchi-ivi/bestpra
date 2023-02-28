<template>

    <!-- :max-height="cardFlg ? 400 : 400" -->
    <div>
        <v-img
            :aspect-ratio="16/9"
            :src="imgUrl ? imgUrl : NoImg"
            contain
            max-height="400"
            width="100%"
        >
        </v-img>
    </div>
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
        },
        // previewFlg: {
        //     type: Boolean,
        //     default: false
        // }
    },
    data() {
        return {
            NoImg
        }
    }
}
</script>