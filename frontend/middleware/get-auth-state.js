import { getAuth,onAuthStateChanged } from 'firebase/auth'
// import { auth } from '@/plugins/firebase'

export default async function({ store, redirect }) {
    console.log("get-auth-sateを実行")

    await new Promise((resolve, reject) => {
        // client only
        if (process.server) return resolve()
        const auth = getAuth()
        onAuthStateChanged(
            auth,
            (user) => {
                if (user) {
                user
                    .getIdToken()
                    .then((idtoken) => {
                        // console.log(user)
                        // console.log(idtoken)
                        store.commit('modules/user/setUser', user.uid)
                        // token.value = idtoken
                    resolve()
                    })
                    .catch(reject)
                } else {
                    // token.value = null
                    store.commit('modules/user/setUser', null)
                    resolve()
                }
            },
            (error) => {
                reject(error)
            }
        )
    })
}
