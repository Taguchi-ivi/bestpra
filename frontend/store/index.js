// import axios from 'axios';

// 共通変数 => vue file = data
// export const state = () => ({
//     styles: {
//         homeAppBarHeight: 56
//     },
//     homeAppBarHeight: 56
// })

// 算出プロパティ => vue file = computed
// export const getters = {
//     styles(state) {
//         return state.styles
//     },
//     homeAppBarHeight: state => state.homeAppBarHeight
// }

// stateの値を変更する場所
// export const mutations = {}

// アプリ全体のメソッドを置く => vue file = methods
// export const actions = {}

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