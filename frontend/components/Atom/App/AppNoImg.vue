<template>
    <div>
        <div v-if="cardFlg">
            <div class="item">
                <div class="item-wrap">
                    <v-img
                        :src="imgUrl ? imgUrl : NoImg"
                        height="168"
                    >
                    </v-img>
                </div>
            </div>
        </div>
        <div v-else>
            <v-img
                :aspect-ratio="16/9"
                :src="imgUrl ? imgUrl : NoImg"
                contain
                max-height="400"
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
    },
    data() {
        return {
            NoImg
        }
    }
}
</script>

<style lang="scss" scoped>
.flex-item {
    // flex-basis: 100%;
    width: 100%;
}

.image-wrap{
    position: relative;
    overflow: hidden;
    padding-top: 60%;
    margin: 10px 5px;
}

.image-wrap img {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%,-50%);
    width: 100%;
    height: 100%;
    object-fit: cover;
}


</style>