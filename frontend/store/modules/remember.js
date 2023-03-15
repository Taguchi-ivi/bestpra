// 一度queryに集約
export const state = () => ({
    rememberPath: {
        name: 'home',
        params: {}
    },
    // ログイン後アクセス不可のルートを列挙する
    redirectPaths: [
        'auth-signup',
        'auth-signin'
    ]
})

export const getters = {
    getRememberPath(state) {
        return state.rememberPath
    },
    getRedirectPaths(state) {
        return state.redirectPaths
    }
}

export const actions = {
    // ログイン前ユーザーがアクセスしたルートを記憶する
    // ログイン前パスが渡された場合はhomeへ遷移する
    getRememberPath({ state, commit }, { name, params }) {
        if(state.redirectPaths.includes(name)){
            name = 'home/all'
        }
        params = params || {}
        commit('setRememberPath', { name, params})
    }
}

export const mutations = {
    setRememberPath( state, payload) {
        state.rememberPath = payload
    }
}