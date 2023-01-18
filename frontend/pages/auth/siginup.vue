<template>
    <div class="auth-page container">
        <div class="auth-container row">
            <form @submit.stop.prevent="onSubmit">
                <input type="email" placeholder="email address">
                <input type="password" placeholder="password">
                <button type="submit" class="is-style-btn_normal btn-primary">{{ isLogin ? "Login" : "Singup" }}</button>
                <a class="switch-link" type="submit" @click="isLogin = !isLogin">Switch to {{ isLogin? "Signup" : "Login" }}</a>
            </form>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                isLogin: true,
                email: "",
                password: ""
            }
        },
        methods: {
            onSubmit() {
                // ログイン(signin用)
                const authUrl = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=" + process.env.ApiKey;
                if(!this.isLogin) {
                    // isLoginがfalse,新規登録時はURLをsiginに変更する
                    authUrl = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key" + process.env.ApiKey
                }
                const signupData = {
                    email: this.email,
                    password: this.password,
                    returnSecureToken: true
                }
                this.$axios.$post(authUrl, signupData)
            }
        }
    };
</script>

<style scoped>
    .switch-link {
        cursor: pointer;
        color: blue;
    }
</style>