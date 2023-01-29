// ログインしていないuserは対象ページにてログインを促す
export default ({ store, redirect }) => {
    // return await store.dispatch('getCurrentArticle', params)
    if (!store.getters['modules/user/isAuthenticated']) {
        return redirect('/auth/signin')
    }
}