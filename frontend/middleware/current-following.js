export default async ({ $auth, store, $axios }) => {

    // ログイン済みの場合のみ実行
    if ($auth.loggedIn()) {
        // ユーザーのフォロー一覧が存在しない場合取得
        const currentFollowing = store.getters['modules/follow/getCurrentFollow'].concat()
        if (currentFollowing.includes('nothing')) {
            await $axios.$get('/api/v1/users/current_following')
                .then((res => {
                    store.commit('modules/follow/setCurrentFollow', res)
                }))
                .catch(err => console.log(err))
        }
    }
}