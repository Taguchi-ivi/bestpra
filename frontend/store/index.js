// import $axios from 'axios'

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

    getCurrentProject({ state, commit}, params) {
        let currentProject = null
        if (params && params.id) {
            const id = Number(params.id)
            currentProject = state.project.list.find(project => project.id === id) || null
        }

        commit('setCurrentProject', currentProject)
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
    },

    // nuxtServerInit({ $auth, $axios }) {
        // console.log('どうよNuxtServiceInit')
    // ↓--
    // async nuxtServerInit({ commit }, { req, app }) {
    //     // export default async ({ $auth, $axios }) => {
    //         // console.log('どうよNuxtServiceInit')
    //         // await $axios.post
    //         //     (
    //         //         '/api/v1/auth_token/refresh',
    //         //         {},
    //         //         { validateStatus: status => $auth.resolveUnauthorized(status) }
    //         //     )
    //         //     .then(response => $auth.login(response))
    //     // }
    //     // await $axios({
    //     //     url: '/api/v1/auth_token/refresh',
    //     //     method: 'POST',
    //     //     data: {},
    //     //     config: { validateStatus: status => $auth.resolveUnauthorized(status) }
    //     // })
    //     //     .then(response => $auth.login(response))
    //     // console.log('reqどうよ', req);
    //     try {
    //         const response = await this.$axios.post
    //             (
    //                 '/api/v1/auth_token/refresh',
    //                 {},
    //                 { validateStatus: status => app.$auth.resolveUnauthorized(status) }
    //             )
    //         app.$auth.login(response)
    //         // レスポンスからデータを取り出してコミットする処理を記述する
    //         // console.log(response)
    //     } catch (error) {
    //         console.error(error)
    //     }
    // }
    // ↑--
}

// stateの値を変更する場所
export const mutations = {
    // setCurrentUser(state,payload) {
    //     state.currentUser = payload
    // }

    setProjectList (state, payload) {
        state.project.list = payload
    },

    setCurrentProject(state, payload) {
        state.project.current = payload
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