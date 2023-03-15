export default async ({ $auth, store, $axios }) => {

    // ログイン済みの場合のみ実行
    if ($auth.loggedIn()) {
        // ユーザーのいいね一覧が存在しない場合取得
        const currentLiked = store.getters['modules/like/getCurrentLike'].concat()
        const allLiked = store.getters['modules/like/getAllLike'].concat()
        if (currentLiked.includes('nothing') || allLiked.includes('nothing')) {
            await $axios.$get('/api/v1/articles/current_liked')
                .then((res => {
                    store.commit('modules/like/setCurrentLike', res.currentLiked)
                    const result = res.likes.map(article => ({id: article.id, likes: article.likes}))
                    store.commit('modules/like/setAllLike', result)
                }))
                .catch(err => console.log(err))
        }
    }
}