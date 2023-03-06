    // articlesデータ

    export const state = () => ({

        articles: [],

        currentArticleData: {},

        // ユーザが書いた記事を管理
        writtenArticles: [],

        // 対象のユーザのいいね一覧を管理
        likesArticle: [],
    })

    export const getters = {

        getArticles(state) {
            return state.articles
        },

        getCurrentArticleData(state) {
            return state.currentArticleData
        },

        getWrittenArticles(state) {
            return state.writtenArticles
        },

        getLikesArticle(state) {
            return state.likesArticle
        }
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

        getResetCurrentArticleData({ commit }) {
            commit('setCurrentArticleData', {
                id: 0,
                title: '',
                content: '',
                created_at: '',
                updated_at: '',
                image: {
                    url: '',
                },
                level_list_id: 0,
                level_list: {},
                tag_list: {},
                user: {
                    id: 0,
                    nickname: '',
                    avatar: {
                        url: '',
                    }
                },
                user_id: 0,
                comments: []
            })
        },

        getWrittenArticles({ commit }, writtenArticles) {
            commit('setWrittenArticles', writtenArticles)
        },

        getLikesArticle({ commit },  likesArticle ) {
            commit('setLikesArticle',  likesArticle )
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

        setWrittenArticles (state, payload) {
            state.writtenArticles = payload
        },


        setLikesArticle (state, payload) {
            state.likesArticle = payload
        },

        // current_userのみ値を更新
        // setCreateLikesArticle (state, article ) {
        //     const result = state.likesArticle.unshift(article)
        //     const sortResult = result.sort((a, b) => b.article_id - a.article_id)
        //     state.likesArticle = sortResult
        //     // state.likesArticle = result
        // },

        // current_userのみ値を削除
        setDeleteLikesArticle (state, payload) {
            const articleId = Number(payload)
            const result = state.likesArticle.filter(item => item.id !== articleId)
            console.log('result', result)
            state.likesArticle = result
        }
    }