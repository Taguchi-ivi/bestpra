<template>
  <v-app>
    <!-- gradient="to top right, rgba(100,115,201,.33), rgba(25,32,72,.7)" -->
    <!-- :aspect-ratio="16/9" -->
    <v-img
      :src="errorImg"
      alt="error-pictore"
      width="500"
    >
      <h1 v-if="error.statusCode === 404">
        {{ pageNotFound }}
      </h1>
      <h1 v-else>
        {{ otherError }}
      </h1>
      <NuxtLink to="/about"> go Home page!! </NuxtLink>
    </v-img>
  </v-app>
</template>

<script>
import errorImg from '~/assets/img/error/error-img.png'

export default {
  name: 'EmptyLayout',
  layout: 'before-login',
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

<style scoped>
h1 {
  font-size: 20px;
}
</style>
