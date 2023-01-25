class MyInject {
    // Nuxtのcontextを使用する場合は、constructor内で初期化する
    constructor (ctx) {
        // ctx => { app }
        this.app = ctx.app
    }
    // i18nページタイトル変換
    pageTitle (routeName){
        // routeName => 'account-settings' =>'pages.account.settings'
        const jsonPath = `pages.${routeName.replace(/-/g, '.')}`
        const title = this.app.i18n.t(jsonPath)
        return title
    }

    // 日付のフォーマット変換
    // 使い方 => $my.dateFormat(日付)
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
}

// inject => オリジナルクラスを追加することができる
// どこからでも呼び出し可能となる
// export default (context, inject)
export default ({ app }, inject) => {
    // inject('呼び出し名', 'クラスのインスタンス(context),)
    // 'my' => $myで呼び出せる
    inject('my', new MyInject({ app }))
}