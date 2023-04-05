<template>
    <user-form-card >

        <template #user-form-card-content>
            <div class="text-center">
                <v-btn
                    :loading="guestLoading"
                    block
                    class="white--text"
                    color="primary"
                    @click="guestLogin"
                >
                    まずはお試し(ゲストログイン)
                </v-btn>
            </div>

            <div
                class="my-8"
            >
                <v-divider />
            </div>
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
                        color="primary"
                    >
                        ログインする
                    </v-btn>
                </v-card-text>
            </v-form>
        </template>
    </user-form-card>
</template>

<script>
import UserFormCard from '~/components/Molecules/UserFormCard'
import UserFormEmail from '~/components/Atom/UserForm/UserFormEmail'
import UserFormPassword from '~/components/Atom/UserForm/UserFormPassword'

export default {
    name: 'SingIn',
    components: {
        UserFormCard,
        UserFormEmail,
        UserFormPassword,
    },
    layout: 'beforeLogin',
    middleware: ['logged-in-redirect'],
    data() {
        return {
            isValid: false,
            loading: false,
            guestLoading: false,
            // params: { auth: { email: 'user0@example.com', password: 'password'} },
            params: { auth: { email: '', password: ''} },
        }
    },
    head(){
        return {
            title: 'Signin Page',
        }
    },
    methods: {
        async formLogin() {
            this.loading = true
            if(this.isValid) {
                await this.$axios.$post('/api/v1/auth_token/login', this.params)
                    .then(res => this.authSuccessful(res))
                    .catch(error => this.authFailure(error))
            }

            this.loading = false
        },
        authSuccessful(res) {
            this.$auth.login(res)
            const redirectPath = this.$route.query.redirect || '/home'
            // this.$my.dispatchToast(true, 'ログインに成功しました!!', 'success')

            this.$router.push(redirectPath)
        },
        authFailure({ response }) {
            if (response && response.status === 404) {
                return this.$my.dispatchToast(true, 'ユーザが見つかりません', 'error')
            }
            // エラー処理
            return this.$my.apiErrorHandler(response)
        },
        async guestLogin() {
            this.guestLoading = true
            await this.$auth.guestUserLogin()
            this.guestLoading = false
            this.$router.push('/home/all')
        }
    },
}
</script>