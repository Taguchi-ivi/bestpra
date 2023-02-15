// import Cookies from 'js-cookie'
// import { getAuth, getIdToken, signOut } from "firebase/auth"
// import { getAuth, getIdToken, signOut } from "firebase/auth"
import {
    getAuth,
    signOut,
    onAuthStateChanged,
    // getIdToken,
    // signInWithEmailAndPassword,
} from 'firebase/auth'
// import jwtDecode from 'jwt-decode'
// import firebaseApp from '~/plugins/firebase'

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
        // const auth = getAuth()
        // const firebaseUser = auth.currentUser
        // const token = getIdToken(firebaseUser, true)
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
        const auth = getAuth();
        await signOut(auth).then(() => {
            // Sign-out successful.
            // Cookies.remove('access_token')
            commit('setUser', null)
        }).catch((error) => {
            // An error happened.
            console.log(error);
        })
    },

    checkAuthState({ commit }) {
        // client only
        console.log("ここの情報が欲しいです")
        if (process.server) return
        const auth = getAuth()
        onAuthStateChanged(auth,(user) => {
            if (user) {
                user
                    .getIdToken()
                        .then((idToken) => {
                            console.log(idToken)
                            console.log(user.uid)
                            commit('setUser', user.uid)
                        })
                    .catch()
            } else {
                // token.value = null
                commit('setUser', null)
            }
        },
        (error) => {
            console.log(error)
        })
    },

    onAuthStateChangedAction({ commit}, { authUser }) {
        if (authUser === null) {
            commit('setUser', null);
            return;
        }
        commit('setUser', authUser.uid)
    }
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