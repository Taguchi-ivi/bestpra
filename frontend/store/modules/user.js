    // userデータ

export const state = () => ({

    // user: {
    //     current: null
    // },
    currentUser: null,

    otherUser: {},

    editUser: {},

    // 様々なユーザー情報を格納
    // userData: {},
    userData: [],
})

export const getters = {

    getUser(state) {
        return state.currentUser
        // return state.currentUser
    },

    getOtherUser(state) {
        return state.otherUser
    },

    getEditUser(state) {
        return state.editUser
    },

    getUserData(state) {
        return state.userData
    }

    // isCurrentUser(state) {
    //     // return !!state.user && !!state.user.uid
    //     // return state.userUid !== null
    //     return state.user.current.id === state.otherData.id
    // }
}

export const actions = {
    getCurrentUser ({ commit }, user) {
        console.log('mutationsOK', user)
        commit('setCurrentUser', user)
    },

    getOtherUser ({ commit }, user) {
        console.log('mutationsOK', user)
        commit('setOtherUser', user)
    },

    getEditUser ({ commit }, user) {
        console.log('mutationsOK', user)
        commit('setEditUser', user)
    },

    getUserData ( { commit }, user) {
        console.log('mutationsOK', user)
        commit('setUserData', user)
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

    setEditUser(state, payload) {
        // console.log(state.user)
        state.editUser = payload
    },

    setUserData(state, payload) {
        // console.log(state.user)
        state.userData = payload
    }
}