// import $axios from 'axios'

// 共通変数 => vue file = data
export const state = () => ({
    auth: {
        token: null,
        expires: 0,
        payload: {}
    },

})

// 算出プロパティ => vue file = computed
export const getters = {
    getAuth(state) {
        // return state.user
        return state.auth
    },
}


// アプリ全体のメソッドを置く => vue file = methods
// { state, getters, commit, dispatch, rootState, rootGetters}
// rootState => ルート(store/index.js)のstateを取得(rootState = state) =>別ファイルのstateをもらう場合
export const actions = {

    getAuthToken ({ commit }, token) {
        commit('setAuthToken', token)
    },

    getAuthExpires ({ commit }, expires) {
        expires = expires || 0
        commit('setAuthExpires', expires)
    },

    getAuthPayload ({ commit }, jwtPayload) {
        jwtPayload = jwtPayload || {}
        commit('setAuthPayload', jwtPayload)
    },

}

// stateの値を変更する場所
export const mutations = {

    setAuthToken (state, payload) {
        state.auth.token = payload
    },

    setAuthExpires (state, payload) {
        state.auth.expires = payload
    },

    setAuthPayload (state, payload) {
        state.auth.payload = payload
    },
}