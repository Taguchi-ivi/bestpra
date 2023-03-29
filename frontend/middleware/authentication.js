

// ログイン済みではないユーザーのリダイレクト処理
export default async ({ $auth, store, route, redirect }) => {
    // リダイレクトを必要としないパス
    // const notRedirectPaths = ['about', 'project', 'users-1']
    const notRedirectPaths = ['about', 'index']
    if (notRedirectPaths.includes(route.name)) {
        return false
    }

    // ログイン前ユーザー処理
    if (!$auth.loggedIn()) {
        // ユーザー以外の値が存在する可能性があるので全てを削除する
        await $auth.logout()

        const status = true
        const msg = 'まずはログインしてください'
        const color = 'info'

        redirect(`/auth/signin?redirect=${route.fullPath}`)
        // トースター出力
        store.dispatch('modules/toast/getToast', { status, msg, color })
    }
}
