export default async ({ $auth, store, $axios }) => {

    // ログイン済みの場合のみ実行
    if ($auth.loggedIn()) {
        // ユーザーのいいね一覧が存在しない場合取得
        const currentLiked = store.getters['modules/like/getCurrentLike'].concat()
        if (currentLiked.includes('nothing')) {
            await $axios.$get('/api/v1/users/current_liked')
                .then((res => {
                    console.log('返却データhello',res)
                    store.dispatch('modules/like/getCurrentLike', res)
                }))
                .catch(err => console.log(err))
        }
    }
}