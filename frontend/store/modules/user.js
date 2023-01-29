import Cookies from 'js-cookie'
import { getAuth, getIdToken, signOut } from "firebase/auth"
// import firebaseApp from '~/plugins/firebase'

export const state = () => ({
    // userデータ
    user: {}
})

export const getters = {
    getUser(state) {
        return state.user
    },

    isAuthenticated(state) {
        return !!state.user && !!state.user.uid
    }
}

export const actions = {
    // ログイン処理を実施
    login({ commit }, user) {
        // console.log('token取得')
        const auth = getAuth()
        const firebaseUser = auth.currentUser
        const token = getIdToken(firebaseUser, true)
        // console.log(token)
        const userInfo = {
            email: user.email,
            uid: user.uid
        }
        // console.log(userInfo)
        Cookies.set('access_token', token)
        commit('setUser', userInfo)
    },

    // ログアウト処理を実施
    async logout({ commit }) {
        const auth = getAuth();
        await signOut(auth).then(() => {
            // Sign-out successful.
            Cookies.remove('access_token')
            commit('setUser', null)
        }).catch((error) => {
            // An error happened.
            console.log(error);
        })
    }
}

export const mutations = {

    setUser(state, payload) {
        // state.user.name = payload.name
        // state.user.email = payload.email
        // state.user.uid = payload.uid
        // console.log('mutations action!')
        // console.log(state.user)
        state.user = payload
        // console.log(state.user)

    },
    // setUid(state, payload) {
    //     state.user = payload
    // }
}