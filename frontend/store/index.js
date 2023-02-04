// import axios from 'axios';
// import { getUserFromCookie } from '@/helpers'
import {
    getAuth,
    onAuthStateChanged,
    // getIdToken,
    // signInWithEmailAndPassword,
} from 'firebase/auth'

// 共通変数 => vue file = data
export const state = () => ({
    // styles: {
    //     homeAppBarHeight: 56
    // },
    // homeAppBarHeight: 56
    // article: {
    //     current: null,
    //     list: [
    //         {id: 1, name: 'article01', updateAt: '2023-01-26-01T12:00:00+09:00'},
    //         {id: 2, name: 'article01', updateAt: '2023-01-27-01T12:00:00+09:00'},
    //         {id: 3, name: 'article01', updateAt: '2023-01-28-01T12:00:00+09:00'},
    //         {id: 4, name: 'article01', updateAt: '2023-01-29-01T12:00:00+09:00'},
    //         {id: 5, name: 'article01', updateAt: '2023-01-30-01T12:00:00+09:00'},
    //     ]
    // }
})

// 算出プロパティ => vue file = computed
export const getters = {
//     styles(state) {
//         return state.styles
//     },
//     homeAppBarHeight: state => state.homeAppBarHeight
    // getUser: state => state.user
}


// アプリ全体のメソッドを置く => vue file = methods
// { state, getters, commit, dispatch, rootState, rootGetters}
// rootState => ルート(store/index.js)のstateを取得(rootState = state) =>別ファイルのstateをもらう場合
export const actions = {
    // getCurrentArtcile ({ state, commit}, params) {
    //     const id = Number(params.id)
    //     const currentArtcile = state.article.list.find(article => article.id === id) || null
    //     commit('setCurrentArticle', currentArtcile)
    // }

    nuxtServerInit ({ commit }, { req }) {
        // console.log('ここまではどう？')
        // console.log(req)
        // const user = getUserFromCookie(req)
        // console.log('---')
        // console.log(user)
        // console.log('--- cokkie情報')
        // if(user) {
        //     const userInfo = {
        //         email: user.email,
        //         uid: user.user_id
        //     }
        //     await commit('modules/user/setUser', userInfo)
        // }
        console.log('server-init')
        if (process.server && process.static) return
        const auth = getAuth()
        const userInfo = auth.currentUser;
        console.log("userInfo =>" + userInfo)
        onAuthStateChanged(auth,(user) => {
            console.log("user => " + user)
            if (user) {
                user
                    .getIdToken()
                        .then((idToken) => {
                            console.log(idToken)
                            console.log(user.uid)
                            commit('modules/user/setUser', user.uid)
                        })
                    .catch()
            } else {
                // token.value = null
                commit('modules/user/setUser', null)
            }
        },
        (error) => {
            console.log(error)
        })
        // if (!process.server) {
        // const { checkAuthState, user_uid } = useAuth()
        // commit('modules/user/checkAuthState')
        console.log('処理通っているか？')
        // }
        // console.log('uid これ')
        // console.log(store.userUid)
    }

}

// stateの値を変更する場所
export const mutations = {
    // setCurrentArticle(state, payload) {
    //     state.article.current = payload
    // }

    // setUid(state, payload) {
    //     state.user = payload
    // }
}