<template>
    <user-form-card >
        <template #user-form-card-content>
            <v-form
                ref="form"
                v-model="isValid"
                @submit.prevent="formSignup"
            >
                <user-form-name
                    :name.sync="params.user.name"
                />
                <user-form-email
                    :email.sync="params.user.email"
                    placeholder
                />
                <user-form-password
                    :password.sync="params.user.password"
                    set-validation
                />
                <v-btn
                    type="submit"
                    :disabled="!isValid || loading"
                    :loading="loading"
                    block
                    class="white--text"
                    color="blue"
                >
                    登録
                </v-btn>
                <!-- {{ params.user }} -->
            </v-form>
        </template>
    </user-form-card>
</template>

<script>

import { getAuth, createUserWithEmailAndPassword } from 'firebase/auth'
import { mapActions } from 'vuex'
import UserFormCard from '~/components/Molecules/UserFormCard'
import UserFormName from '~/components/Atom/UserForm/UserFormName'
import UserFormEmail from '~/components/Atom/UserForm/UserFormEmail'
import UserFormPassword from '~/components/Atom/UserForm/UserFormPassword'

export default {
    name: 'singup',
    components: {
        UserFormCard,
        UserFormName,
        UserFormEmail,
        UserFormPassword,
    },
    layout: 'beforeLogin',
    middleware: ['logged-in-user'],
    data() {
        return {
            isValid: false,
            loading: false,
            params: {user: { name: '', email: '', password: ''} }
        }
    },
    methods: {
        ...mapActions({
            login: 'modules/user/login',
        }),
        async formSignup() {
            this.loading = true
            // setTimeout(() => {
            //     this.formReset()
            //     this.loading = false

            // }, 1500)
            // console.log(this.params.user.email)
            // console.log(this.params.user.password)
            const auth = getAuth();
            // console.log('ここまでOK')
            await createUserWithEmailAndPassword(auth, this.params.user.email, this.params.user.password)
                .then((userCredential) => {
                    // Signed in
                    const user = userCredential.user;
                    // user.displayName = this.params.user.name
                    // console.log(user);
                    this.login(user);

                    this.$router.push('/home')
                    this.formReset();
                })
                .catch((error) => {
                    const errorCode = error.code;
                    const errorMessage = error.message;
                    console.log(errorCode);
                    console.log(errorMessage);
                    // ..

                    // this.formReset();
                });
        },
        formReset() {
            this.loading = false
            this.$refs.form.reset()
            for (const key in this.params.user) {
                this.params.user[key] = ''
            }

        }
    },
}
</script>