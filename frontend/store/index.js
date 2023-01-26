// import axios from 'axios';

// 共通変数 => vue file = data
export const state = () => ({
    // styles: {
    //     homeAppBarHeight: 56
    // },
    // homeAppBarHeight: 56
    article: {
        current: null,
        list: [
            {id: 1, name: 'article01', updateAt: '2023-01-26-01T12:00:00+09:00'},
            {id: 2, name: 'article01', updateAt: '2023-01-27-01T12:00:00+09:00'},
            {id: 3, name: 'article01', updateAt: '2023-01-28-01T12:00:00+09:00'},
            {id: 4, name: 'article01', updateAt: '2023-01-29-01T12:00:00+09:00'},
            {id: 5, name: 'article01', updateAt: '2023-01-30-01T12:00:00+09:00'},
        ]
    }
})

// 算出プロパティ => vue file = computed
// export const getters = {
//     styles(state) {
//         return state.styles
//     },
//     homeAppBarHeight: state => state.homeAppBarHeight
// }

// stateの値を変更する場所
export const mutations = {
    setCurrentArticle(state, payload) {
        state.article.current = payload
    }
}


// アプリ全体のメソッドを置く => vue file = methods
// { state, getters, commit, dispatch, rootState, rootGetters}
// rootState => ルート(store/index.js)のstateを取得(rootState = state) =>別ファイルのstateをもらう場合
export const actions = {
    getCurrentArtcile ({ state, commit}, params) {
        const id = Number(params.id)
        const currentArtcile = state.article.list.find(article => article.id === id) || null
        commit('setCurrentArticle', currentArtcile)
    }
}

// const createStore = () => {
//     return new Vuex.Store({
//         state: {
//             token: "",
//             user: {}
//         },
//         getters: {

//         },

//         mutations: {
//             // stateのtokenにトークンを保存
//             setToken(state, token) {
//                 state.token = token;
//             },
//             // stateのtokenをトークンに保存
//             setUser(state, user) {
//                 state.user = user;
//             },
//         },

//         actions: {
//             authenticateUser({commit}, authData) {
//                 const authUrl = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=" + process.env.ApiKey;
//                 if(!authData.isLogin) {
//                     // isLoginがfalse,新規登録時はURLをsiginに変更する
//                     authUrl = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key" + process.env.ApiKey
//                 }

//                 // axios通信の結果をreturnすることで、submitに処理が返される
//                 return this.$axios.$post("https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=" + process.env.ApiKey, {
//                     email: authData.email,
//                     password: authData.password,
//                     returnSecureToken: true
//                 })
//                 .then(result => {
//                     // returnSecureTokenの値、result.tokenをcommit
//                     commit('setToken', result.idToken)
//                     $nuxt.$router.push('/')
//                 })
//                 .catch(e => console.log(e))
//             }
//         }
//     })
// }

// const createStore = () => {
//     return new Vuex.Store({
//         state: {
//             token: "",
//             user: {},
//             styles: {
//                 homeAppBarHeight: 56
//             }
//         },
//         getters: {

//         },
//     })
// }

// export default createStore;