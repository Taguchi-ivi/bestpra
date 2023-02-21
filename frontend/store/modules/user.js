

export const state = () => ({

    user: {
        current: null
    },
    // userデータ
    otherUser: {},
    editUser: {}
})

export const getters = {

    getUser(state) {
        return state.user.current
        // return state.currentUser
    },

    getOtherUser(state) {
        return state.otherUser
    },

    getEditUser(state) {
        return state.editUser
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



}

export const mutations = {

    setCurrentUser (state, payload) {
        state.user.current = payload
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
}