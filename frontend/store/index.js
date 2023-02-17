
// 共通変数 => vue file = data
export const state = () => ({
    user: {
        current: null
    },
    project: {
        current: null,
        list: []
    },
    // currentUser: null,
    auth: {
        token: null,
        expires: 0,
        payload: {}
    }
})

// 算出プロパティ => vue file = computed
export const getters = {
    getUser(state) {
        return state.user
        // return state.currentUser
    },
    getAuth(state) {
        // return state.user
        return state.auth
    },
}


// アプリ全体のメソッドを置く => vue file = methods
// { state, getters, commit, dispatch, rootState, rootGetters}
// rootState => ルート(store/index.js)のstateを取得(rootState = state) =>別ファイルのstateをもらう場合
export const actions = {

    getProjectList({ commit }, projects) {
        projects = projects || []
        commit('setProjectList', projects)
    },

    getCurrentUser ({ commit }, user) {
        console.log('mutationsOK', user)
        commit('setCurrentUser', user)
    },

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
    }
}

// stateの値を変更する場所
export const mutations = {
    // setCurrentUser(state,payload) {
    //     state.currentUser = payload
    // }

    setProjectList (state, payload) {
        state.project.list = payload
    },

    setCurrentUser (state, payload) {
        state.user.current = payload
        // state.currentUser = payload
    },

    setAuthToken (state, payload) {
        state.auth.token = payload
    },

    setAuthExpires (state, payload) {
        state.auth.expires = payload
    },

    setAuthPayload (state, payload) {
        state.auth.payload = payload
    }
}