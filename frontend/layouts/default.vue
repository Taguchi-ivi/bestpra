<template>
  <v-app>
    <logged-in-home-header />
    <v-main>
    <!-- <v-container> -->
      <AppToaster />
      <margin-top />
      <Nuxt />
      <PageTop />
      <margin-bottom />
    <!-- </v-container> -->
    </v-main>
    <logged-in-home-footer />
  </v-app>
</template>

<script>
import LoggedInHomeHeader from '~/components/Organisms/LoggedIn/LoggedInHomeHeader.vue'
import LoggedInHomeFooter from '~/components/Organisms/LoggedIn/LoggedInHomeFooter.vue'
import marginTop from '~/components/Atom/margin/marginTop.vue'
import marginBottom from '~/components/Atom/margin/marginBottom.vue'
import AppToaster from '~/components/Atom/App/AppToaster.vue'
import PageTop from '~/components/Atom/App/AppPageTop.vue'

export default {
  name: 'LayoutDefault',
  components: {
    LoggedInHomeHeader,
    LoggedInHomeFooter,
    marginTop,
    marginBottom,
    AppToaster,
    PageTop,
  },
  middleware: ['nuxt-server-init','authentication','get-notification','current-liked', 'current-following'],
}
</script>
