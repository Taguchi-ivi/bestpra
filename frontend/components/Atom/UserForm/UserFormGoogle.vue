<template>
    <v-card
        flat
        width="100%"
        max-width="320"
        color="transparent"
        class="mx-auto"
    >
        <div
            class="text-center ma-5"
        >
            <v-btn
                class="pa-5"
                @click="googleLogin"
            >
                <v-img
                    :src="GoogleIcon"
                    height="20"
                    width="20"
                />
                <span class="ml-3">
                    ログイン
                </span>
            </v-btn>
        </div>
        <v-divider
            class="my-8"
        >
        </v-divider>
    </v-card>
</template>

<script>
import { mapActions } from 'vuex'
import {
    signInWithPopup,
    GoogleAuthProvider,
    getAuth
    // getIdToken
} from 'firebase/auth'
// import { auth } from '@/plugins/firebase'
import GoogleIcon from '~/assets/img/google/google-icon.svg'

export default {
    data() {
        return {
            GoogleIcon
        }
    },
    ...mapActions({
        login: 'modules/user/login',
    }),
    methods: {
        async googleLogin() {
            // const loginWithGoogle = async () => {
            //     const provider = new GoogleAuthProvider();
            //     const result = await signInWithPopup(auth, provider);
            //     if (result) {
            //         const user = result.user;
            //         const credential = GoogleAuthProvider.credentialFromResult(result);
            //         const token = credential?.accessToken;

            //     }
            // }
            const auth = getAuth();
            const provider = new GoogleAuthProvider();
            await signInWithPopup(auth, provider)
            .then((result) => {
                // This gives you a Google Access Token. You can use it to access the Google API.
                const credential = GoogleAuthProvider.credentialFromResult(result);
                const token = credential.accessToken;
                // The signed-in user info.
                const user = result.user;
                // IdP data available using getAdditionalUserInfo(result)
                // ...

                alert(user + credential + token)
                const config = {
                    headers: {
                        authorization: `Bearer ${token}`,
                    }
                }

                const res = this.$axios.post('/authentication',null,config)
                if (res.status !== 200) {
                    throw new Error('login error!');
                }
                this.$router.push('/home')
            }).catch((error) => {
                // Handle Errors here.
                const errorCode = error.code;
                const errorMessage = error.message;
                // The email of the user's account used.
                const email = error.customData.email;
                // The AuthCredential type that was used.
                const credential = GoogleAuthProvider.credentialFromError(error);
                console.log(errorCode + "|" + errorMessage + "|" + email + "|" + credential)
                // ...
            });
            // const result = await signInWithPopup(auth, provider);
            // if (result) {
            //     const user = result.user;
            //     const credential = GoogleAuthProvider.credentialFromResult(result);
            //     const token = credential?.accessToken;
            //     alert(user + credential + token)
            //     this.login(user)
            //     const idToken = await user.getIdToken();
            //     const config = {
            //         headers: {
            //             authorization: `Bearer ${idToken}`,
            //         }
            //     }

            //     const res = this.$axios.post('/authentication',null,config)
            //     if (res.status !== 200) {
            //         throw new Error('login error!');
            //     }
            //     this.$router.push('/home')
            // }

        },
    },
}
</script>