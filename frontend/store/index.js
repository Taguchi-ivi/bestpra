// import $axios from 'axios'

// 共通変数 => vue file = data
export const state = () => ({
    // user: {
    //     current: null
    // },
    project: {
        current: null,
        list: []
    },
    // currentUser: null,
    auth: {
        token: null,
        expires: 0,
        payload: {}
    },

})

// 算出プロパティ => vue file = computed
export const getters = {
    // getUser(state) {
    //     return state.user
    //     // return state.currentUser
    // },
    getAuth(state) {
        // return state.user
        return state.auth
    },

    getToaster(state) {
        return state.toast
    }
}


// アプリ全体のメソッドを置く => vue file = methods
// { state, getters, commit, dispatch, rootState, rootGetters}
// rootState => ルート(store/index.js)のstateを取得(rootState = state) =>別ファイルのstateをもらう場合
export const actions = {

    getProjectList({ commit }, projects) {
        projects = projects || []
        commit('setProjectList', projects)
    },

    getCurrentProject({ state, commit}, params) {
        let currentProject = null
        if (params && params.id) {
            const id = Number(params.id)
            currentProject = state.project.list.find(project => project.id === id) || null
        }

        commit('setCurrentProject', currentProject)
    },

    // getCurrentUser ({ commit }, user) {
    //     console.log('mutationsOK', user)
    //     commit('setCurrentUser', user)
    // },

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

    getToast({ commit }, { msg, color, timeout }) {
        color = color || 'error'
        timeout = timeout || 4000
        commit('setToast', { msg, color, timeout })
    },

}

// stateの値を変更する場所
export const mutations = {

    setProjectList (state, payload) {
        state.project.list = payload
    },

    setCurrentProject(state, payload) {
        state.project.current = payload
    },

    // setCurrentUser (state, payload) {
    //     state.user.current = payload
    //     // state.currentUser = payload
    // },

    setAuthToken (state, payload) {
        state.auth.token = payload
    },

    setAuthExpires (state, payload) {
        state.auth.expires = payload
    },

    setAuthPayload (state, payload) {
        state.auth.payload = payload
    },

    // setToast (state, payload) {
    //     state.Toast = payload
    // }
}