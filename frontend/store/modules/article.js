    // articlesデータ

    export const state = () => ({

        articles: [],

        currentArticleData: {},
    })

    export const getters = {

        getArticles(state) {
            return state.articles
        },

        getCurrentArticleData(state) {
            return state.currentArticleData
        },
    }

    export const actions = {

        getArticles({ commit }, articles) {
            // console.log(('articles', articles))
            commit('setArticles', articles)
        },

        getCurrentArticleData ({ commit }, articleData) {
            // console.log('article', articleData)
            commit('setCurrentArticleData', articleData)
        },

    }

    export const mutations = {

        setArticles (state, payload) {
            state.articles = payload
            // state.currentUser = payload
        },

        setCurrentArticleData (state, payload) {
            state.currentArticleData = payload
            // state.currentUser = payload
        },
    }