
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
        return this.store.state.user.current || {}
    }

    // 認証情報をVuexに保存する
    setAuth ({ token, expires, user }) {
        const exp = expires * 1000
        const jwtPayload = (token) ? jwtDecode(token) : {}

        this.store.dispatch('getAuthToken', token)
        this.store.dispatch('getAuthExpires', exp)
        this.store.dispatch('getCurrentUser', user)
        this.store.dispatch('getAuthPayload', jwtPayload)
    }

    // ログイン業務
    login (response) {
        this.setAuth(response)
    }
}

export default ({ store, $axios }, inject) => {
    inject('auth', new Authentication({ store, $axios }))
}
