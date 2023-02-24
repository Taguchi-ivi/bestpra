<template>
    <user-form-card >
        <template #user-form-card-content>
            <!-- <p v-if="errMsg">
                <v-alert
                    border="left"
                    color="pink darken-1"
                    dark
                    >
                    {{ errMsg }}
                </v-alert>
            </p> -->
            <v-form
                ref="form"
                v-model="isValid"
                @submit.prevent="formSignup"
            >
                <user-form-name
                    :nickname.sync="params.user.nickname"
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
                    :password-again.sync="passwordAgain"
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

import { mapActions } from 'vuex'
import UserFormCard from '~/components/Molecules/UserFormCard'
import UserFormName from '~/components/Atom/UserForm/UserFormName'
import UserFormEmail from '~/components/Atom/UserForm/UserFormEmail'
import UserFormPassword from '~/components/Atom/UserForm/UserFormPassword'
import UserFormPasswordAgain from '~/components/Atom/UserForm/UserFormPasswordAgain'

export default {
    name: 'singUp',
    components: {
        UserFormCard,
        UserFormName,
        UserFormEmail,
        UserFormPassword,
        UserFormPasswordAgain,
    },
    layout: 'beforeLogin',
    middleware: ['logged-in-redirect'],
    data() {
        return {
            isValid: false,
            loading: false,
            errMsg: '',
            params: {
                user: {
                    nickname: '',
                    email: '',
                    password: '',
                    activated: true,
                }
            },
            passwordAgain: '',
            // users: {}
        }
    },
    methods: {
        ...mapActions({
            login: 'modules/user/login',
        }),
        // testBtn() {
            // const user = {
            //     nickname: this.params.user.name,
            //     email: this.params.user.email,
            //     uid: 'aaaaaaaaaa'
            // }
            // this.$axios.post('/api/v1/users', { user })
            //     .then(response => {
            //             console.log(response)
            //         })
            // this.$axios.get('/api/v1/users')
            //     .then(response => {
            //         const users = response
            //         return users
            //     })
        // },
        async formSignup() {

            const password = this.params.user.password
            if(password !== this.passwordAgain) {
                const status = true
                const msg = 'パスワードと確認用パスワードが一致しません'
                const color = 'error'
                return this.$store.dispatch('modules/toast/getToast', { status, msg, color })
            }
            this.loading = true
            // setTimeout(() => {
            //     this.formReset()
            //     this.loading = false

            // }, 1500)
            if(this.isValid) {
                await this.$axios.$post('/api/v1/auth_token', this.params)
                    .then((res) => {
                        console.log('formsigunup',res)
                        // const status = true
                        // const msg = '登録が完了しました!!'
                        // const color = 'success'
                        // this.$store.dispatch('modules/toast/getToast', { status, msg, color })
                        this.$auth.login(res)
                        this.$router.push('/home')
                    })
                    .catch((err) => {
                        console.log('errやで', err)
                    })
            }
            this.loading = false
            // console.log(this.params.user.email)
            // console.log(this.params.user.password)
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