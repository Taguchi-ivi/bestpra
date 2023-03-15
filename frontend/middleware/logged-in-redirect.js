
export default ({ $auth, store, route, redirect }) => {
    // ログイン済ユーザーをリダイレクトさせる
    const redirectPaths = store.getters['modules/remember/getRedirectPaths']
    if ($auth.loggedIn() && redirectPaths.includes(route.name)) {
        const status = true
        const msg = 'ログイン済みです!!'
        const color = 'info'
        // トースター出力
        redirect('/home/all')
        store.dispatch('modules/toast/getToast', { status, msg, color,})
        // return redirect('/home')
    }
}
