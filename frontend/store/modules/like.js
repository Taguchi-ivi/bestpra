export const state = () => ({
    allLike: ['nothing'],

    currentLiked: ['nothing'],
})

export const getters = {
    getAllLike(state) {
        return state.allLike
    },

    getCurrentLike(state) {
        return state.currentLiked
    },
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
        state.allLike = payload
    },

    // Likeに記事を追加
    setAddAllLike (state, payload) {
        state.allLike.unshift(payload)
    },

    // Likeの記事を削除
    setDelAllLike (state, payload) {
        state.allLike.unshift(payload)
    },

    // Likeの件数を増やす
    setUpAllLike (state, { articleId, userId }) {
        const result = state.allLike.map(d => {
            if (d.id === articleId) {
                d.likes.push({ user_id: userId })
            }
            return d
        })
        state.allLike = result
    },

    // Likeの件数を減らす
    setDownAllLike (state, { articleId, userId }) {
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
        state.currentLiked = payload
    },

    setCreateCurrentLike (state, payload) {
        state.currentLiked.push(Number(payload))
    },

    setDeleteCurrentLike (state, payload) {
        const currentLikeId = Number(payload)
        const result = state.currentLiked.filter(currentLiked => currentLiked !== currentLikeId)
        state.currentLiked = result
    },
}