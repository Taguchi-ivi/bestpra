<template id="error-page">
  <v-app>
    <margin-top />
    <!-- gradient="to top right, rgba(100,115,201,.33), rgba(25,32,72,.7)" -->
    <!-- :aspect-ratio="16/9" -->
    <v-container class="mx-auto">
      <v-img
        :src="errorImg"
        alt="error-pictore"
        max-width="500"
        class="mx-auto"
        :aspect-ratio="16/9"
      >
        <h1 v-if="error.statusCode === 404" class="text-center">
          {{ pageNotFound }}
        </h1>
        <h1 v-else>
          {{ otherError }}
        </h1>
        <!-- <div class="imgBlue ml-auto">
          <NuxtLink to="/about"> go Home page!! </NuxtLink>
        </div> -->
      </v-img>
    </v-container>
  </v-app>
</template>

<script>
import errorImg from '~/assets/img/error/error-img.png'
import marginTop from '~/components/Atom/margin/marginTop.vue'

export default {
  name: 'EmptyLayout',
  components: {
    marginTop
  },
  layout: 'beforeLogin',
  props: {
    error: {
      type: Object,
      default: null,
    },
  },
  data() {
    return {
      pageNotFound: 'Sorry... 404 Not Found',
      otherError: 'An error occurred',
      errorImg
    }
  },
  head() {
    const title =
      this.error.statusCode === 404 ? this.pageNotFound : this.otherError
    return {
      title,
    }
  },
}
</script>

<style lang="scss" scoped>
#error-page {
  h1 {
    font-size: 20px;
  }

}
</style>
