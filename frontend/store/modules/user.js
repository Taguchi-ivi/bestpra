    // userデータ

export const state = () => ({
    currentUser: null,

    otherUser: {},

    // 様々なユーザー情報を格納
    userData: [],

    searchUsers: [],
})

export const getters = {
    getUser(state) {
        return state.currentUser
    },

    getOtherUser(state) {
        return state.otherUser
    },

    getUserData(state) {
        return state.userData
    },

    getSearchUsers(state) {
        return state.searchUsers
    }
}

export const actions = {
    getCurrentUser ({ commit }, user) {
        if(!user) {
            user = {
                id: null,
                nickname: null,
                avatar: { url: null },
                admin: false,
                sub: null
            }
        }
        commit('setCurrentUser', user)
    },

    getOtherUser ({ commit }, user) {

        if (!user) {
            user = {
                id: null,
                nickname: null,
                avatar: { url: null },
                introduction: null,
                current_user: false
            }
        }
        commit('setOtherUser', user)
    },

    getUserData ( { commit }, user) {
        commit('setUserData', user)
    },

    getSearchUsers( { commit }, user) {
        commit('setSearchUsers', user)
    },

    getResetSearchUsers( { commit }) {
        commit('setSearchUsers', [])
    }
}

export const mutations = {
    setCurrentUser (state, payload) {
        state.currentUser = payload
    },

    setOtherUser(state, payload) {
        state.otherUser = payload
    },

    setFollowOtherUser(state) {
        const result = state.otherUser
        result.followers++
        state.otherUser = result
    },

    setUnfollowOtherUser(state) {
        const result = state.otherUser
        result.followers--
        state.otherUser = result
    },

    setUserData(state, payload) {
        state.userData = payload
    },

    setSearchUsers(state, payload) {
        state.searchUsers = payload
    },
}