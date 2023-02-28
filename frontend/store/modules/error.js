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
        // errorStatus = errorStatus || false
        commit('setErrorStatus', errorStatus )
    }

}


export const mutations = {

    setErrorStatus (state, payload) {
        console.log('mutationsのこれは何？', payload)
        state.errorStatus = payload
    }
}