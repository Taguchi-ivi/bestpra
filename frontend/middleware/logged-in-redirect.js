
export default ({ $auth, store, route, redirect }) => {
    // ログイン済ユーザーをリダイレクトさせる
    // console.log('middleware->loggedin', redirectPaths)
    // console.log('route.name', route.name)
    const redirectPaths = store.getters['modules/remember/getRedirectPaths']
    if ($auth.loggedIn() && redirectPaths.includes(route.name)) {
        const msg = 'ログイン済みです!!'
        const color = 'indigo'
        // const color = 'error'
        const status = true
        // トースター出力
        store.dispatch('modules/toast/getToast', { status, msg, color,})
        return redirect('/home')
    }
}
