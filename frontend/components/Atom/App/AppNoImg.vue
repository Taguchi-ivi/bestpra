<template>
    <!-- width="100%"
    height="auto" -->
    <v-img
        :aspect-ratio="16/9"
        :src="img ? img : NoImg"
        contain
        max-height="400"
    >
    </v-img>
</template>

<script>
import NoImg from '~/assets/img/card/coming-soon.jpg'
export default {
    props: {
        img: {
            type: String,
            default: ''
        }
    },
    data() {
        return {
            NoImg
        }
    }
}
</script>