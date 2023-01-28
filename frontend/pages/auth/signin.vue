<template>
    <user-form-card >
        <template #user-form-card-content>
            <v-form
                ref="form"
                v-model="isValid"
                @submit.prevent="formLogin"
            >
                <user-form-email
                    :email.sync="params.user.email"
                />
                <user-form-password
                    :password.sync="params.user.password"
                />
                <!-- <v-card-actions>
                    <nuxt-link
                        to="#"
                        class="body-2 text-decoration-none"
                    >
                        パスワードを忘れた？
                    </nuxt-link>
                </v-card-actions> -->
                <div class="my-8"></div>
                <v-card-text
                    class="px-0"
                >
                    <v-btn
                        type="submit"
                        :disabled="!isValid || loading"
                        :loading="loading"
                        block
                        class="white--text"
                        color="blue"
                    >
                        ログインする
                    </v-btn>
                </v-card-text>
                <!-- {{ params.user }} -->
            </v-form>
        </template>
    </user-form-card>
</template>

<script>
import { getAuth, signInWithEmailAndPassword } from 'firebase/auth'
import UserFormCard from '~/components/Molecules/UserFormCard'
import UserFormEmail from '~/components/Atom/UserForm/UserFormEmail'
import UserFormPassword from '~/components/Atom/UserForm/UserFormPassword'

export default {
    components: {
        UserFormCard,
        UserFormEmail,
        UserFormPassword,
    },
    layout: 'beforeLogin',
    data() {
        return {
            isValid: false,
            loading: false,
            params: {user: { email: '', password: ''} }
        }
    },
    methods: {
        formLogin() {
            this.loading = true
            // setTimeout(() => {this.loading = false}, 1500)

            const auth = getAuth();
            signInWithEmailAndPassword(auth, this.params.user.email, this.params.user.password)
            .then((userCredential) => {
                // Signed in
                const user = userCredential.user;
                console.log(user);
                // ...
            })
            .catch((error) => {
                const errorCode = error.code;
                const errorMessage = error.message;
                console.log(errorCode)
                console.log(errorMessage)
            });
            this.loading = false
            // this.$router.push('/home')
        }
    },
}
</script>