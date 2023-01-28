// import axios from 'axios';
import firebase from '~/plugins/firebase'
import { getAuth } from "firebase/auth"

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
    // userデータ
    user: {}
})

// 算出プロパティ => vue file = computed
export const getters = {
//     styles(state) {
//         return state.styles
//     },
//     homeAppBarHeight: state => state.homeAppBarHeight
    // getUser: state => state.user
    getUser(state) {
        return state.user
    }
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
    async login({ dispatch, state }, user) {
        console.log('token取得')
        const token = await firebaseApp.auth().currentUser.getIdToken(true)
        const userInfo = {
            name: user.displayName,
            email: user.email,
            uid: user.uid
        }

    }
}

// stateの値を変更する場所
export const mutations = {
    // setCurrentArticle(state, payload) {
    //     state.article.current = payload
    // }

    setUser(state, payload) {
        state.user = payload
    }
}