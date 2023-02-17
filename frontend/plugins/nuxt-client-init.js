
// ログイン状態を維持する
// 401エラー許容する
// export default async ({ $auth, $axios }) => {
export default ({ $auth, $axios }) => {
    console.log('nuxt-client-init出力')
    // if(process.server) {
    //     await $axios.$post
    //         (
    //             '/api/v1/auth_token/refresh',
    //             {},
    //             { validateStatus: status => $auth.resolveUnauthorized(status) }
    //         )
    //         .then(response => $auth.login(response))
    // }
}
