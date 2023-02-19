// import Cookies from 'js-cookie'
// import jwtDecode from 'jwt-decode'

export const state = () => ({
    // userデータ
    // user: {}
    userUid: null
})

export const getters = {
    getUser(state) {
        // return state.user
        return state.userUid
    },

    isAuthenticated(state) {
        // return !!state.user && !!state.user.uid
        return state.userUid !== null
    }
}

export const actions = {
    // ログイン処理を実施
    login({ commit }, user) {
        // console.log('token取得')

        // console.log(token.PromiseResult)
        // console.log('↓でdecode')
        // const decodeToken = jwtDecode(token)
        // console.log(token.access_token)
        // const userInfo = {
        //     email: user.email,
        //     uid: user.uid
        // }
        // console.log(userInfo)
        // Cookies.set('access_token', token)
        commit('setUser', user.uid)
    },

    // ログアウト処理を実施
    async logout({ commit }) {
        // const auth = getAuth();
        // await signOut(auth).then(() => {
        //     // Sign-out successful.
        //     // Cookies.remove('access_token')
        //     commit('setUser', null)
        // }).catch((error) => {
        //     // An error happened.
        //     console.log(error);
        // })
    },


}

export const mutations = {

    setUser(state, payload) {
        // state.user.name = payload.name
        // state.user.email = payload.email
        // state.user.uid = payload.uid
        // console.log('mutations action!')
        // console.log(state.user)
        state.userUid = payload
        // console.log(state.user)

    },
    // setUid(state, payload) {
    //     state.user = payload
    // }
}