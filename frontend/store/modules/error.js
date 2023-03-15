export const state = () => ({
    errorStatus: false
})

export const getters = {
    getErrorStatus(state) {
        return state.errorStatus
    }
}

export const actions = {
    getErrorStatus({ commit }, errorStatus ) {
        commit('setErrorStatus', errorStatus )
    }
}


export const mutations = {
    setErrorStatus (state, payload) {
        state.errorStatus = payload
    }
}