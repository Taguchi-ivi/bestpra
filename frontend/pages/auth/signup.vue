<template>
    <user-form-card >
        <template #user-form-card-content>
            <p v-if="errMsg">
                <v-alert
                    border="left"
                    color="pink darken-1"
                    dark
                    >
                    {{ errMsg }}
                </v-alert>
            </p>
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
                <user-form-password-again
                    :password-again.sync="params.user.passwordAgain"
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
                <!-- <v-btn
                    class="white--text"
                    color="blue"
                    @click="testBtn"
                >
                    テスト
                </v-btn> -->
                <!-- {{ params.user }} -->
                <!-- {{ users }} -->
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
import UserFormPasswordAgain from '~/components/Atom/UserForm/UserFormPasswordAgain'

export default {
    name: 'singup',
    components: {
        UserFormCard,
        UserFormName,
        UserFormEmail,
        UserFormPassword,
        UserFormPasswordAgain
    },
    layout: 'beforeLogin',
    middleware: ['logged-in-user'],
    data() {
        return {
            isValid: false,
            loading: false,
            errMsg: '',
            params: {user: { name: '', email: '', password: '', passwordAgain: ''} },
            // users: {}
        }
    },
    methods: {
        ...mapActions({
            login: 'modules/user/login',
        }),
        // testBtn() {
        //     // const user = {
        //     //     nickname: this.params.user.name,
        //     //     email: this.params.user.email,
        //     //     uid: 'aaaaaaaaaa'
        //     // }
        //     // this.$axios.post('/api/v1/users', { user })
        //     //     .then(response => {
        //     //             console.log(response)
        //     //         })
        //     this.$axios.get('/api/v1/users')
        //         .then(response => {
        //             const users = response
        //             return users
        //         })
        // },
        async formSignup() {

            const password = this.params.user.password
            const passwordAgain = this.params.user.passwordAgain
            if(password !== passwordAgain) {
                this.errMsg = 'パスワードと確認用パスワードが一致しません'
                return
            }
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
                    const firebaseAuthUser = userCredential.user;
                    // user.displayName = this.params.user.name
                    // console.log(user);
                    this.login(firebaseAuthUser);
                    // const user = {
                    //     nickname: this.params.user.name,
                    //     email: firebaseAuthUser.email,
                    //     uid: firebaseAuthUser.uid
                    // }
                    // this.$axios.post('/api/v1/users', { user })
                    //     .then(response => {
                    //         // console.log(response)
                    //     })

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