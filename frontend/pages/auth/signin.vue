<template>
    <user-form-card >
        <template #user-form-card-content>
            <v-form
                ref="form"
                v-model="isValid"
                @submit.prevent="formLogin"
            >
                <user-form-email
                    :email.sync="params.auth.email"
                />
                <user-form-password
                    :password.sync="params.auth.password"
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
// import { mapActions } from 'vuex'
import UserFormCard from '~/components/Molecules/UserFormCard'
import UserFormEmail from '~/components/Atom/UserForm/UserFormEmail'
import UserFormPassword from '~/components/Atom/UserForm/UserFormPassword'

export default {
    name: 'singIn',
    components: {
        UserFormCard,
        UserFormEmail,
        UserFormPassword,
    },
    layout: 'beforeLogin',
    middleware: ['logged-in-user'],
    data() {
        return {
            isValid: false,
            loading: false,
            params: { auth: { email: 'user0@example.com', password: 'password'} },
            // params: {auth: { email: '', password: ''} }
        }
    },
    methods: {
        // ...mapActions({
        //     login: 'modules/user/login',
        // }),
        async formLogin() {
            this.loading = true
            // setTimeout(() => {this.loading = false}, 1500)
            if(this.isValid) {
                await this.$axios.$post('/api/v1/auth_token', this.params)
                    .then(res => this.authSuccessful(res))
                    .catch(error => this.authFailure(error))
            }

            this.loading = false
        },
        authSuccessful(res) {
            // console.log('authSuccessful', res)
            this.$auth.login(res)
            console.log('token',this.$auth.token)
            console.log('expires',this.$auth.expires)
            console.log('payload',this.$auth.payload)
            console.log('user',this.$auth.user)
            // TODO 記憶ルートリダイレクト
            this.$router.push('/home')
        },
        authFailure({ response }) {
            if (response && response.status === 404) {
                // トースター出力
                // alert('404')
                const status = true
                const msg = 'ユーザが見つかりません'
                const color = 'error'
                return this.$store.dispatch('modules/toast/getToast', { status, msg, color })
            }
            // TODO エラー処理
            // alert(response.status)
        }
    },
}
</script>