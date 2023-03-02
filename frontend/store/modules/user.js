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

    // editUser: {},
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

    // getEditUser(state) {
    //     return state.editUser
    // },

    // isCurrentUser(state) {
    //     // return !!state.user && !!state.user.uid
    //     // return state.userUid !== null
    //     return state.user.current.id === state.otherData.id
    // }
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
    }

    // getEditUser ({ commit }, user) {
    //     console.log('mutationsOK', user)
    //     commit('setEditUser', user)
    // },


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
    }

    // setEditUser(state, payload) {
    //     // console.log(state.user)
    //     state.editUser = payload
    // },
}