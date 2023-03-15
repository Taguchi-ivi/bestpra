export const state = () => ({
    toast: {
        status: false,
        msg: null,
        color: 'transparent',
        timeout: 4000
    }
})

export const getters = {
    getToast(state) {
        return state.toast
    }
}

export const actions = {
    getToast({ commit }, { status, msg, color, timeout }) {
        status = status || false
        color = color || 'transparent'
        timeout = timeout || 4000
        commit('setToast', { status, msg, color, timeout })
    }
}


export const mutations = {
    setToast (state, payload) {
        state.toast = payload
    }
}