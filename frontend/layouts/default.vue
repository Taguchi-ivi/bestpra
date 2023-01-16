<template>
  <v-app>
    <!-- <v-app-bar>
    </v-app-bar> -->
    <v-app-bar
      color="primary"
      fixed
      elevate-on-scroll
    >
      <!-- <v-app-bar-nav-icon></v-app-bar-nav-icon> -->
      <nuxt-link to="/about">
        <v-img width="50" src="/header-logo.png"></v-img>
      </nuxt-link>
      <v-toolbar-title>bestpra</v-toolbar-title>

      <v-spacer></v-spacer>

      <div class="my-auto">
        <v-text-field
          label="Filled"
          placeholder="Dense & Rounded"
          filled
          rounded
          dense
          ></v-text-field>
      </div>
      <v-btn icon>
        <v-icon>mdi-magnify</v-icon>
      </v-btn>

      <!-- <v-btn icon>
        <v-icon>mdi-heart</v-icon>
      </v-btn> -->

      <v-btn icon>
        <v-icon>mdi-dots-vertical</v-icon>
      </v-btn>
    </v-app-bar>
    <v-main>
    <!-- <v-container> -->
      <Nuxt />
    <!-- </v-container> -->
    </v-main>
    <div class="footer-m my-15"></div>
    <div class="footer-m my-15"></div>
    <!-- v-bind="localAttrs" -->
    <v-footer
      :padless="padless"
      color="accent"
      absolute
    >
      <v-card
        flat
        tile
        width="100%"
        class="accent text-center"
      >
        <v-card-text>
          <v-btn
            v-for="icon in icons"
            :key="icon"
            class="mx-4"
            icon
          >
            <v-icon size="24px">
              {{ icon }}
            </v-icon>
          </v-btn>
        </v-card-text>

        <v-divider></v-divider>

        <v-card-text class="white--text">
          <!-- {{ new Date().getFullYear() }} — <strong>Vuetify</strong> -->
          <strong>portfolio | k.t</strong>
        </v-card-text>
      </v-card>
    </v-footer>
  </v-app>
</template>
<!--
<script src="https://kit.fontawesome.com/14a540a64c.js" crossorigin="anonymous">
-->
<script>
export default {
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
