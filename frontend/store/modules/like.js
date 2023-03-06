export const state = () => ({
    allLike: ['nothing'],

    currentLiked: ['nothing'],

    // likesArticle: ['nothing'],
})

export const getters = {
    getAllLike(state) {
        return state.allLike
    },

    getCurrentLike(state) {
        return state.currentLiked
    },

    // getLikesArticle(state) {
    //     return state.likesArticle
    // }
}

export const actions = {
    getAllLike({ commit },  allLike ) {
        commit('setAllLike',  allLike )
    },

    getCurrentLike({ commit },  currentLiked ) {
        commit('setCurrentLike',  currentLiked )
    },

    // getLikesArticle({ commit },  likesArticle ) {
    //     commit('setLikesArticle',  likesArticle )
    // },


}


export const mutations = {

    // indexのLikeを管理
    setAllLike (state, payload) {
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
    },


    // // いいねした記事を管理
    // setLikesArticle (state, payload) {
    //     state.likesArticle = payload
    // },

    // setCreateLikesArticle (state, article ) {
    //     const result = state.likesArticle.unshift(article)
    //     const sortResult = result.sort((a, b) => b.article_id - a.article_id)
    //     state.likesArticle = sortResult
    //     // state.likesArticle = result
    // },

    // setDeleteLikesArticle (state, articleId) {
    //     const result = state.likesArticle.filter(article => article.id !== articleId)
    //     state.likesArticle = result
    // }


}