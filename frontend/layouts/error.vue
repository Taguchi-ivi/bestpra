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
        <v-row>
        <v-col
          cols="12"
        >
          <v-card-title
            class="justify-center"
          >
            {{ error.statusCode }}
          </v-card-title>
          <v-card-text
            class="text-center"
          >
            {{ errorMessage }}
          </v-card-text>
          <v-card-actions
            class="justify-center"
          >
            <v-btn
              icon
              x-large
              @click="redirect"
            >
              <v-icon>
                mdi-home
              </v-icon>
            </v-btn>
          </v-card-actions>
        </v-col>
      </v-row>
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
  computed: {
    // ログイン前後でリダイレクトパスを切り替える
    redirectPath () {
      const loggedInHomePath = 'about'
      const beforeLoginHomePath = { name: 'about' }
      return this.$auth.loggedIn()
        ? loggedInHomePath : beforeLoginHomePath
    },
    // axiosエラーの場合はstatusTextを参照する
    responsedMessage () {
      return (this.error.response && this.error.response.statusText)
        ? this.error.response.statusText : this.error.message
    },
    // i18nに翻訳パスが存在する場合は日本語翻訳メッセージを返す
    errorMessage () {
      const translationPath = `error.${this.responsedMessage}`
      return this.$te(translationPath)
        ? this.$t(translationPath) : this.responsedMessage
    }
  },
  async created () {
    // 認証エラーの場合はVuexを初期化する(セッションはサーバで削除済み)
    if (this.error.statusCode === 401) {
      await this.$auth.resetVuex()
    }
  },
  methods: {
    // リダイレクトパスが現在のルートと一致している場合はリロードを行う
    redirect () {
      this.redirectPath.name === this.$route.name
        ? this.$router.go() : this.$router.push(this.redirectPath)
    }
  }
}
</script>

<style lang="scss" scoped>
#error-page {
  h1 {
    font-size: 20px;
  }

}
</style>
