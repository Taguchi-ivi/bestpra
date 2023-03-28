export const state = () => ({
    currentFollow: ['nothing'],

    otherFollower: [],
})

export const getters = {
    getCurrentFollow(state) {
        return state.currentFollow
    },

    getOtherFollower(state) {
        return state.otherFollower
    }
}

export const actions = {
    getCurrentFollow({ commit }, currentFollow ) {
        commit('setCurrentFollow', currentFollow )
    },

    getOtherFollower({ commit }, otherFollower ) {
        commit('setOtherFollower', otherFollower )
    }
}


export const mutations = {
    setCurrentFollow (state, payload) {
        state.currentFollow = payload
    },

    setCreateCurrentFollow (state, payload) {
        const UserId = Number(payload)
        state.currentFollow.push(UserId)
    },

    setDeleteCurrentFollow (state, payload) {
        const UserId = Number(payload)
        const result = state.currentFollow.filter(user => user !== UserId)
        state.currentFollow = result
    },


    setOtherFollower (state, payload) {
        state.otherFollower = payload
    },

    setCreateOtherFollower (state, payload) {
        state.otherFollower.unshift(payload)
    },

    setDeleteOtherFollower (state, payload) {
        const UserId = Number(payload)
        const result = state.otherFollower.filter(user => user.id !== UserId)
        state.otherFollower = result
    }
}