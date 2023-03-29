
export default async ({ $auth, $axios, store, route, redirect, isDev }) => {

    // userが存在する && refresh-tokenの有効期限が切れた場合に処理を実行する
    // catch -> access-tokenも期限が切れている場合
    if ($auth.isExistUserAndExpired()) {
        // if (isDev) {
        //     console.log('Execute silent refresh!!')
        // }
        await $axios.$post('/api/v1/auth_token/refresh')
            .then(response => $auth.login(response))
            .catch(() => {
                // Vuexの初期化(セッションはサーバで削除済み)
                $auth.resetVuex()
                if(route.name === 'logout') {
                    return redirect('/about')
                } else {
                    const status = true
                    const msg = "セッションの有効期限が切れました。\n" +
                                "もう一度ログインしてください"
                    const color = 'error'

                    redirect(`/auth/signin?redirect=${route.fullPath}`)

                    // トースター出力
                    store.dispatch('modules/toast/getToast', { status, msg, color })
                }
            })
    }
}
