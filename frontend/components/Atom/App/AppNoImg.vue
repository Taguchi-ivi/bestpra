<template>

    <!-- :max-height="cardFlg ? 400 : 400" -->
    <div>
        <div v-if="!previewFlg">
            <v-img
                :aspect-ratio="16/9"
                :src="imgUrl ? $my.portFix(imgUrl) : NoImg"
                contain
                max-height="400"
                width="100%"
            >
            </v-img>
        </div>
        <div v-else>
            <v-img
                :aspect-ratio="16/9"
                :src="imgUrl ? imgUrl : NoImg"
                contain
                max-height="400"
                width="100%"
            >
            </v-img>
        </div>
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
        previewFlg: {
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