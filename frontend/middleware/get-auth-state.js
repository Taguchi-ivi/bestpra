

// // export default async function({ store, redirect }) {
export default async function({ store, redirect, $auth, $axios }) {
    console.log("get-auth-sateを実行")
    if(process.server) {
        console.log('middlewareで実行')
        await $axios.$post
            (
                '/api/v1/auth_token/refresh',
                {},
                { validateStatus: status => $auth.resolveUnauthorized(status) }
            )
            .then(response => $auth.login(response))
    }

}
