export const state = () => ({
    articleComment: []
})

export const getters = {
    getArticleComment(state) {
        return state.articleComment
    }
}

export const actions = {
    getArticleComment({ commit }, articleComment ) {
        commit('setArticleComment', articleComment )
    },

    getResetArticleComment({ commit }) {
        commit('setArticleComment', [{
            article_id: 0,
            content: '',
            created_at: '',
            id: 0,
            updated_at: '',
            user: {
                id: 0,
                nickname: '',
                avatar: {
                    url: '',
                }
            },
            user_id: 0,
        }])
    }
}

export const mutations = {
    setArticleComment (state, payload) {
        state.articleComment = payload
    },

    // commentを追加する
    setPushArticleComment(state, payload) {
        state.articleComment.push(payload)
    },

    // commentを削除する
    setDeleteArticleComment(state, payload) {
        const commentId = Number(payload)
        const result = state.articleComment.filter(comment => comment.id !== commentId)
        state.articleComment = result
    },
}