import colors from 'vuetify/es5/util/colors'

// CkEditor
const path = require('path')
const CKEditorWebpackPlugin = require("@ckeditor/ckeditor5-dev-webpack-plugin")
const CKEditorStyles = require("@ckeditor/ckeditor5-dev-utils").styles

// env切り替え
// const environment = process.env.NODE_ENV || 'development';
// const envSet = require(`./env.${environment}.js`);

export default {

  // env: envSet,
  env: {
    // ApiKey: process.env.FIREBASE_API_KEY,
    // authDomain: process.env.FIREBASE_AUTH_DOMAIN,
    // projectId: process.env.FIREBASE_PROJECTID,
    // storageBucket: process.env.FIREBASE_STORAGEBUCKET,
    // messagingSenderId: process.env.FIREBASE_MESSAGINGSENDERID,
    // appId: process.env.FIREBASE_APPID,
    // measurementId: process.env.FIREBASE_MEASUREMENTID
    // privateKey: process.env.FIREBASE_PRIVATE_KEY,
    // clientEmail: process.env.FIREBASE_CLIENT_EMAIL,

  },
  // Global page headers: https://go.nuxtjs.dev/config-head
  head: {
    titleTemplate: '%s | bestpra',
    title: 'bestpra',
    htmlAttrs: {
      // lang: 'en',
      lang: 'ja',
    },
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: '' },
      { name: 'format-detection', content: 'telephone=no' },
    ],
    // link: [{ rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }],
    link: [{ rel: 'icon', type: 'image/png', href: '/favicon.png' }],
  },

  // Global CSS: https://go.nuxtjs.dev/config-css
  css: [
    '~/assets/main.scss'
  ],

  // Plugins to run before rendering page: https://go.nuxtjs.dev/config-plugins
  plugins: [
    { src: '~/plugins/auth.js'},
    { src: '~/plugins/axios.js'},
    { src: '~/plugins/nuxt-server-init.js', mode: 'server'},
    { src: '~/plugins/my-inject.js'},
    { src: '~/plugins/ckeditor.js', mode: 'client'},
    // { src: '~/plugins/firebase.js', mode: 'client'},
    // { src: '~/plugins/authentication.js'},
    // 'plugins/my-inject'
  ],

  // middleware
  router: {
    // middleware: ['silent-refresh-token','get-auth-state']
    middleware: ['silent-refresh-token', 'current-liked']
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
  server: {
    port: 8080
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
          info: '#B5EAEA',
          imgBlue: '#6871fc',
          warning: colors.amber.base,
          error: colors.deepOrange.accent4,
          success: colors.green.accent3,
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
    // CkEditor
    plugins: [
      // If you set ssr: true that will cause the following error. This error does not affect the operation.
      // ERROR  [CKEditorWebpackPlugin] Error: No translation has been found for the zh language.
      new CKEditorWebpackPlugin({
        // See https://ckeditor.com/docs/ckeditor5/latest/features/ui-language.html
        // language: "ja",
        additionalLanguages: 'all',
        addMainLanguageTranslationsToAllAssets: true,
      })
    ],

    // If you don't add postcss, the CKEditor css will not work.
    postcss: CKEditorStyles.getPostCssConfig({
      themeImporter: {
        themePath: require.resolve("@ckeditor/ckeditor5-theme-lark")
      },
      minify: true
    }),

  },
}
