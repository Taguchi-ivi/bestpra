    // userデータ

export const state = () => ({

    // user: {
    //     current: null
    // },
    currentUser: null,

    otherUser: {},

    // 様々なユーザー情報を格納
    // userData: {},
    userData: [],

    searchUsers: [],
})

export const getters = {

    getUser(state) {
        return state.currentUser
        // return state.currentUser
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
        // console.log('mutationsOK', user)
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
        console.log('mutationsOK', user)

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
        console.log('mutationsOK', user)
        commit('setUserData', user)
    },

    getSearchUsers( { commit }, user) {
        console.log('mutationsOK', user)
        commit('setSearchUsers', user)
    },

    getResetSearchUsers( { commit }) {
        commit('setSearchUsers', [])
    }



}

export const mutations = {

    setCurrentUser (state, payload) {
        state.currentUser = payload
        // state.currentUser = payload
    },

    setOtherUser(state, payload) {
        // console.log(state.user)
        state.otherUser = payload
    },

    setUserData(state, payload) {
        // console.log(state.user)
        state.userData = payload
    },

    setSearchUsers(state, payload) {
        // console.log(state.user)
        state.searchUsers = payload
    },


}