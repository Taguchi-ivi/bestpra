export default async ({ $auth, store, $axios }) => {

    // ログイン済みの場合のみ実行
    if ($auth.loggedIn()) {
        // ページ遷移の度に通知を受け取る
        await $axios.$get('/api/v1/notifications/read')
            .then((res => {
                store.commit('modules/notification/setNotificationHeader', res)
            }))
            .catch(err => console.log(err))
    }
}