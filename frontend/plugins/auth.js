
import jwtDecode from 'jwt-decode'

class Authentication {
    constructor (ctx) {
        this.store = ctx.store
        this.$axios = ctx.$axios
    }

    get token () {
        return this.store.state.auth.token
    }

    get expires () {
        return this.store.state.auth.expires
    }

    get payload () {
        return this.store.state.auth.payload
    }

    get user () {
        // return this.store.getters['modules/user/getUser'].current || {}
        return this.store.getters['modules/user/getUser'] || {}
    }

    // 認証情報をVuexに保存する
    setAuth ({ token, expires, user }) {
        const exp = expires * 1000
        const jwtPayload = (token) ? jwtDecode(token) : {}

        this.store.dispatch('getAuthToken', token)
        this.store.dispatch('getAuthExpires', exp)
        // this.store.dispatch('getCurrentUser', user)
        this.store.dispatch('modules/user/getCurrentUser', user)
        this.store.dispatch('getAuthPayload', jwtPayload)
    }

    // ログイン業務
    login (response) {
        // this.resetVuex()
        this.setAuth(response)
    }

    // Vuexの値を初期値に戻す(全て削除する)
    resetVuex () {
        this.setAuth({ token: null, expires: 0, user: null })
        this.store.dispatch('modules/user/getCurrentUser', null)
        this.store.dispatch('modules/follow/getCurrentFollow', ['nothing'])
        this.store.dispatch('modules/like/getCurrentLike', ['nothing'])
        this.store.dispatch('modules/notification/getNotificationHeader', [])
        this.store.dispatch('modules/notification/getNotifications', [])
    }

    // axiosのレスポンス401を許容する
    // Doc: https://github.com/axios/axios#request-config
    resolveUnauthorized(status) {
        return (status >= 200 && status < 300) || (status === 401) // default
    }

    // logoutのみ401エラーを許容して、vuexの値をリセットする
    // '/api/v1/auth_token',
    async logout() {
        await this.$axios.$delete(
            '/api/v1/auth_token/logout',
            { validateStatus: status => this.resolveUnauthorized(status)}
        )
        this.resetVuex()
    }

    // 有効期限内にtrueを返す
    isAuthenticated () {
        return new Date().getTime() < this.expires
    }

    // ユーザーが存在している場合はtrueを返す
    isExistUser () {
        return this.user.sub && this.payload.sub && this.user.sub === this.payload.sub
    }

    // ユーザーが存在し、かつ有効期限切れの場合にtrueを返す
    isExistUserAndExpired () {
        return this.isExistUser() && !this.isAuthenticated()
    }

    // ユーザーが存在し、かつ有効期限内の場合にtrueを返す
    loggedIn () {
        return this.isExistUser() && this.isAuthenticated()
    }

    // ゲストユーザーか判定
    guestUser() {
        return this.user.guest_flg === true
    }

    // ゲストユーザーで対応できない処理の場合、エラー内容を返す
    guestErrMsg(msg) {
        if(this.guestUser()){
            const status = true
            const color = 'error'
            this.store.dispatch('modules/toast/getToast', { status, msg, color })
            return true
        }
        return false
    }

    // ゲストユーザーでログイン
    async guestUserLogin() {
        const status = true
        let msg = ''
        let color = ''
        if (this.guestUser() || this.loggedIn()) {
            msg = 'ログイン済みです!!'
            color = 'info'
        } else {
            const response = await this.$axios.$post('/api/v1/auth_token/guest')
            this.setAuth(response)
            msg = 'ゲストユーザーでログインしました!!'
            color = 'success'
        }
        // this.$router.push('/home/all')
        return this.store.dispatch('modules/toast/getToast', { status, msg, color })
    }
}

export default ({ store, $axios }, inject) => {
    inject('auth', new Authentication({ store, $axios }))
}
