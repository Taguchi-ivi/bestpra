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

    // プロジェクトリンク
    projectLnkTo(id, name = 'project-id-dashboard') {
        return { name, params: { id } }
    }

    // apiのエラーハンドリング
    apiErrorHandler(response) {
        // ネットワークエラーの場合はresponseが存在しないので500を代入
        const statusCode = (response) ? response.status : 500
        const message = (response) ? response.statusText : 'Network Error'
        return this.error({statusCode, message})
    }

    // いいねされているかを確認
    liked(articleId) {
        const currentLiked = this.store.getters['modules/like/getCurrentLike'] || []
        return currentLiked.includes(articleId)
    }

    // いいねの件数を取得
    likeCount(articleId) {
        const AllLike = this.store.getters['modules/like/getAllLike'] || []
        return AllLike.find(like => like.id === articleId).likes.length
    }

    async createLike(articleId, cardFlg) {
        await this.$axios.$post(`/api/v1/articles/${articleId}/like`)
            .then(res => {
                this.store.commit('modules/like/setCreateCurrentLike', articleId)
                if(cardFlg) {
                    this.store.commit('modules/like/setCreateAllLike', {
                            articleId,
                            userId: this.user.id,
                    })
                }
            })
            .catch( err => {
                console.log(err)
            })
    }

    async unlike(articleId, cardFlg) {
        await this.$axios.$delete(`/api/v1/articles/${articleId}/like`)
            .then(res => {
                this.store.commit('modules/like/setDeleteCurrentLike', articleId)
                if(cardFlg) {
                    this.store.commit('modules/like/setDeleteAllLike', {
                            articleId,
                            userId: this.user.id,
                    })
                }
            })
            .catch( err => {
                console.log(err)
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