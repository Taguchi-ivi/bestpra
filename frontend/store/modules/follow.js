export const state = () => ({
    currentFollow: ['nothing'],
})

export const getters = {
    getCurrentFollow(state) {
        return state.currentFollow
    }
}

export const actions = {
    getCurrentFollow({ commit }, currentFollow ) {
        // errorStatus = errorStatus || false
        commit('setErrorStatus', currentFollow )
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
}