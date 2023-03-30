import colors from 'vuetify/es5/util/colors'

// CkEditor
const path = require('path')
const CKEditorWebpackPlugin = require("@ckeditor/ckeditor5-dev-webpack-plugin")
const CKEditorStyles = require("@ckeditor/ckeditor5-dev-utils").styles

// env切り替え
// const environment = process.env.NODE_ENV || 'development';
// const envSet = require(`./env.${environment}.js`);

export default {
  ssr: false,
  // env: envSet,
  env: {

  },
  // Global page headers: https://go.nuxtjs.dev/config-head
  head: {
    titleTemplate: '%s | bestpra',
    title: 'bestpra',
    htmlAttrs: {
      // lang: 'en',
      lang: 'ja',
      prefix: 'og: http://ogp.me/ns#'
    },
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: 'あなたにあったサッカーの練習メニューが見つかる。それがbestpra' },
      { name: 'format-detection', content: 'telephone=no' },
      { hid: 'og:site_name', property: 'og:site_name', content: 'bestpra(ベストプラ)' },
      { hid: 'og:type', property: 'og:type', content: 'website' },
      { hid: 'og:url', property: 'og:url', content: 'https://app.best-pra.com' },
      { hid: 'og:title', property: 'og:title', content: 'bestpra(ベストプラ)' },
      { hid: 'og:description', property: 'og:description', content: 'あなたにあったサッカーの練習メニューが見つかる。それがbestpra' },
      { hid: 'og:image', property: 'og:image', content: 'https://app.best-pra.com/ogp/ogp-image.png' },
      { name: 'twitter:card', content: 'summary' }// twitterの画像サイズ
    ],
    // link: [{ rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }],
    link: [{ rel: 'icon', type: 'image/png', href: '/favicon.png' }],
  },

  // Global CSS: https://go.nuxtjs.dev/config-css
  css: [
    '~/assets/main.scss',
  ],

  // Plugins to run before rendering page: https://go.nuxtjs.dev/config-plugins
  plugins: [
    { src: '~/plugins/auth.js'},
    { src: '~/plugins/axios.js'},
    { src: '~/plugins/my-inject.js'},
    { src: '~/plugins/ckeditor.js', mode: 'client'},
    // { src: '~/plugins/nuxt-server-init.js'},
  ],

  // middleware
  router: {
    middleware: ['silent-refresh-token']
  },

  // Auto import components: https://go.nuxtjs.dev/config-components
  // components: true,
  components: false,

  // Modules for dev and build (recommended): https://go.nuxtjs.dev/config-modules
  buildModules: [
    // https://go.nuxtjs.dev/eslint
    '@nuxtjs/eslint-module',
    // https://go.nuxtjs.dev/vuetify
    '@nuxtjs/vuetify',
  ],

  // Modules: https://go.nuxtjs.dev/config-modules
  modules: [
    // https://go.nuxtjs.dev/axios
    '@nuxtjs/axios',
    '@nuxtjs/i18n'
  ],

  // Axios module configuration: https://go.nuxtjs.dev/config-axios
  axios: {
    // Workaround to avoid enforcing hard-coded localhost:3000: https://github.com/nuxt-community/axios-module/issues/308
    // baseURL: '/',
    // baseURL: 'http://localhost:3000'
    baseURL: process.env.NODE_ENV === 'production' ? 'https://api.best-pra.com' : 'http://localhost:3000',

    // credentials => session情報をRailsと共有する(クロスドメインで認証情報を共有)
    // Doc:https://axios.nuxtjs.org/options/#credentials
    credentials: true
  },

  // localでの作業効率化のため、defultの3000から変更
  // TODO local本番環境の場合は下記をコメントアウト
  server: {
    port: process.env.NODE_ENV === 'production' ? 3000 : 8080,
  },

  // Vuetify module configuration: https://go.nuxtjs.dev/config-vuetify
  vuetify: {
    // カスタムcssのパス
    customVariables: ['~/assets/variables.scss'],
    // カスタムcssを有効化
    treeShake: true,
    theme: {
      dark: false,
      light: true,
      themes: {
        // dark: {
        //   primary: colors.blue.darken2,
        //   accent: colors.grey.darken3,
        //   secondary: colors.amber.darken3,
        //   info: colors.teal.lighten1,
        //   warning: colors.amber.base,
        //   error: colors.deepOrange.accent4,
        //   success: colors.green.accent3,
        // },
        light: {
          primary: '#3F51B5',   // #EDF6E5
          accent: '#F38BA0',
          secondary: '#FFBCBC',
          imgBlue: '#6871fc',
          info: '#03A9F4',  //#B5EAEA
          warning: colors.amber.base,
          error: colors.deepOrange.accent4,
          success: '#4CAF50'
          // success: colors.green.accent3,
        },
      },
      options: { customProperties: true , variations: false},
    },
  },

  // Doc: https://nuxt-community.github.io/nuxt-i18n/basic-usage.html#nuxt-link
  i18n: {
    locales: ['ja', 'en'],
    defaultLocale: 'ja',
    // Doc: https://kazupon.github.io/vue-i18n/api/#properties
    // ルート名__jaを追加しない
    strategy: 'no_prefix',
    vueI18n: {
      fallbackLocale: 'ja',
      // silentTranslationWarn: true,
      silentFallbackWarn: true,
      messages: {
        ja: require('./locales/ja.json'),
        en: require('./locales/en.json')
      }
    }
  },

  // Build Configuration: https://go.nuxtjs.dev/config-build
  build: {

    // lodash
    transpile: [
      'lodash-es'
    ],
  },
}
