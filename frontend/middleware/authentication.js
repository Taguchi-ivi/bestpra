

// ログイン済みではないとページの対応
// middleware: ['authentication'],
export default async ({ $auth, store, route, redirect }) => {
    // リダイレクトを必要としないパス
    // const notRedirectPaths = ['about', 'project', 'users-1']
    const notRedirectPaths = ['about']
    if (notRedirectPaths.includes(route.name)) {
        return false
    }

    // ログイン前ユーザー処理
    if (!$auth.loggedIn()) {
        // ユーザー以外の値が存在する可能性があるので全てを削除する
        await $auth.logout()

        const msg = 'まずはログインしてください'
        const color = 'info'
        // const color = 'error'
        const status = true

        redirect(`/auth/signin?redirect=${route.fullPath}`)
        // トースター出力
        store.dispatch('modules/toast/getToast', { status, msg, color })
        // アクセスルート記憶
        // store.dispatch('modules/remember/getRememberPath', route)
        // return redirect('/auth/signin')
        // return redirect(`/auth/signin?redirect=${route.fullPath}`)
    }
}
