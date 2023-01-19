<template>
  <v-app>
    <home-header />
    <v-main>
    <!-- <v-container> -->
      <Nuxt />
    <!-- </v-container> -->
    </v-main>
    <!-- <footer></footer> -->
    <home-footer />
  </v-app>
</template>
<!--
<script src="https://kit.fontawesome.com/14a540a64c.js" crossorigin="anonymous">
-->
<script>
import HomeHeader from '~/components/Home/HomeHeader'
import HomeFotter from '~/components/Home/HomeFooter'
export default {
  component: {
    HomeHeader,
    HomeFooter
  },
  data: () => ({
    icons: [
      'mdi-home',
      'mdi-email',
      'mdi-calendar',
      'mdi-delete',
    ],
    items: [
      'default',
      'absolute',
      'fixed',
    ],
    padless: false,
    variant: 'default',
    drawer: false,
      group: null,
  }),

}
</script>
