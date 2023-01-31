// ログイン処理実施済みのuserはlogin/signupページを表示しない
export default ({ store, redirect }) => {
    // return await store.dispatch('getCurrentArticle', params)
    if (store.getters['modules/user/isAuthenticated']) {
        return redirect('/home')
    }
}