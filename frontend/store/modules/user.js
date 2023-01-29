import Cookies from 'js-cookie'
import { getAuth, getIdToken } from "firebase/auth"
// import firebaseApp from '~/plugins/firebase'

export const state = () => ({
    // userデータ
    user: {}
})

export const getters = {
    getUser(state) {
        return state.user
    }
}

export const actions = {
    async login({ commit }, user) {
        // console.log('token取得')
        const auth = getAuth()
        const firebaseUser = auth.currentUser
        const token = await getIdToken(firebaseUser, true)
        // console.log(token)
        const userInfo = {
            email: user.email,
            uid: user.uid
        }
        // console.log(userInfo)
        Cookies.set('access_token', token)
        await commit('setUser', userInfo)

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

    },
    // setUid(state, payload) {
    //     state.user = payload
    // }
}