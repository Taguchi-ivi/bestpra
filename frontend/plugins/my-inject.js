class MyInject {
    // Nuxtのcontextを使用する場合は、constructor内で初期化する
    constructor (ctx) {
        // ctx => { app }
        this.app = ctx.app
        this.store = ctx.store
        this.$axios = ctx.$axios
        this.error = ctx.error
    }

    get user () {
        // return this.store.getters['modules/user/getUser'].current || {}
        return this.store.getters['modules/user/getUser'] || {}
    }

    // i18nページタイトル変換
    pageTitle (routeName){
        // routeName => 'account-settings' =>'pages.account.settings'
        const jsonPath = `pages.${routeName.replace(/-/g, '.')}`
        const title = this.app.i18n.t(jsonPath)
        return title
    }

    // 日付のフォーマット変換
    // 使い方 => $my.dataFormat(日付)
    dataFormat(dateStr) {
        const dateTimeFormat = new Intl.DateTimeFormat(
            'ja', { dateStyle: 'medium', timeStyle: 'short' }
        )
        return dateTimeFormat.format(new Date(dateStr))
    }

    // apiのエラーハンドリング
    apiErrorHandler(response) {
        // ネットワークエラーの場合はresponseが存在しないので500を代入
        const statusCode = (response) ? response.status : 500
        const message = (response) ? response.statusText : 'Network Error'
        return this.error({statusCode, message})
    }

    // 文字列の長さを調整
    shortVersion(text, textCount) {
        return text.length > textCount ? `${text.slice(0, textCount)}...` : text
    }

    // nicknameのmarginを指定
    userMarginTop(userId) {
        return this.isFollowed(userId) ? 'mt-1' : 'mt-3'
    }

    // いいねされているかを確認
    liked(articleId) {
        const currentLiked = this.store.getters['modules/like/getCurrentLike'] || []
        return currentLiked.includes(articleId)
    }

    // いいねの処理
    async createLike(article, cardFlg) {
        await this.$axios.$post(`/api/v1/articles/${article.id}/like`)
            .then(res => {
                this.store.commit('modules/like/setCreateCurrentLike', article.id)
                // this.store.commit('modules/like/setCreateLikesArticle', article)
                if(cardFlg) {
                    this.store.commit('modules/like/setUpAllLike', {
                            articleId: article.id,
                            userId: this.user.id,
                    })
                }
            })
            .catch( err => {
                console.log(err)
            })
    }

    // いいね解除
    async unlike(article, cardFlg, userHomeFlg) {
        await this.$axios.$delete(`/api/v1/articles/${article.id}/like`)
            .then(res => {
                this.store.commit('modules/like/setDeleteCurrentLike', article.id)
                if(cardFlg) {
                    this.store.commit('modules/like/setDownAllLike', {
                            articleId: article.id,
                            userId: this.user.id,
                    })
                }
                if(userHomeFlg) {
                    this.store.commit('modules/article/setDeleteLikesArticle', article.id)
                }
            })
            .catch( err => {
                console.log(err)
            })
    }

    // current_userか判定
    isCurrentUser(userId) {
        return Number(userId) === this.user.id
    }

    // フォロー済みか判定
    isFollowed(userId) {
        const followingUsers = this.store.getters['modules/follow/getCurrentFollow'] || []
        return followingUsers.includes(userId)
    }

    dispatchToast(status, msg, color) {
        this.store.dispatch('modules/toast/getToast', {
            status,
            msg,
            color
        })
    }
}

// inject => オリジナルクラスを追加することができる
// どこからでも呼び出し可能となる
// export default (context, inject)
export default ({ app, error, $axios, store }, inject) => {
    // inject('呼び出し名', 'クラスのインスタンス(context),)
    // 'my' => $myで呼び出せる
    inject('my', new MyInject({ app, error, $axios, store }))
}