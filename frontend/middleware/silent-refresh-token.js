
export default async ({ $auth, $axios, store, route, redirect, isDev }) => {

    // userが存在する && refresh-tokenの有効期限が切れた場合に処理を実行する
    // catch -> access-tokenも期限が切れている場合
    if ($auth.isExistUserAndExpired()) {
        if (isDev) {
            console.log('Execute silent refresh!!')
        }
        await $axios.$post('/api/v1/auth_token/refresh')
            .then(response => $auth.login(response))
            .catch(() => {
            const status = true
            const msg = 'セッションの有効期限が切れました。' +
                        'もう一度ログインしてください'
            const color = 'error'
            // トースター出力
            store.dispatch('modules/toast/getToast', { status, msg, color })
            // TODO アクセスルート記憶
            // store.dispatch('getRememberPath', route)
            // Vuexの初期化(セッションはサーバで削除済み)
            $auth.resetVuex()
            return redirect('/auth/signin')
        })
    }
}
