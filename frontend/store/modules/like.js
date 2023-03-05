export const state = () => ({
    allLike: [],

    currentLiked: ['nothing'],
})

export const getters = {
    getAllLike(state) {
        return state.allLike
    },

    getCurrentLike(state) {
        return state.currentLiked
    }
}

export const actions = {
    getAllLike({ commit },  allLike ) {
        commit('setAllLike',  allLike )
    },

    getCurrentLike({ commit },  currentLiked ) {
        commit('setCurrentLike',  currentLiked )
    },


}


export const mutations = {

    // indexのLikeを管理
    setAllLike (state, payload) {
        console.log('alllikeのこれは何？', payload)
        state.allLike = payload
    },

    setCreateAllLike (state, { articleId, userId }) {
        const result = state.allLike.map(d => {
            if (d.id === articleId) {
                d.likes.push({ user_id: userId })
            }
            return d
        })
        state.allLike = result
    },

    setDeleteAllLike (state, { articleId, userId }) {
        const result = state.allLike.map(d => {
            if (d.id === articleId) {
                d.likes = d.likes.filter(like => like.user_id !== userId)
            }
            return d
        })
        state.allLike = result
    },


    // 自身のLikeを管理
    setCurrentLike (state, payload) {
        // console.log('mutationsのこれは何？', payload)
        state.currentLiked = payload
    },

    setCreateCurrentLike (state, payload) {
        // state.currentLike = payload
        state.currentLiked.push(Number(payload))
    },

    setDeleteCurrentLike (state, payload) {
        const currentLikeId = Number(payload)
        const result = state.currentLiked.filter(currentLiked => currentLiked !== currentLikeId)
        state.currentLiked = result
    }

}