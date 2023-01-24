<template>
    <user-form-card >
        <template #user-form-card-content>
            <v-form
                ref="form"
                v-model="isValid"
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
                    :disabled="!isValid || loading"
                    :loading="loading"
                    block
                    class="white--text"
                    color="blue"
                    @click="signup"
                >
                    登録
                </v-btn>
                <!-- {{ params.user }} -->
            </v-form>
        </template>
    </user-form-card>
</template>

<script>
import UserFormCard from '~/components/Molecules/UserFormCard'
import UserFormName from '~/components/Atom/UserForm/UserFormName'
import UserFormEmail from '~/components/Atom/UserForm/UserFormEmail'
import UserFormPassword from '~/components/Atom/UserForm/UserFormPassword'

export default {
    components: {
        UserFormCard,
        UserFormName,
        UserFormEmail,
        UserFormPassword,
    },
    data() {
        return {
            isValid: false,
            loading: false,
            params: {user: { name: '', email: '', password: ''} }
        }
    },
    methods: {
        signup() {
            this.loading = true
            setTimeout(() => {
                this.formReset()
                this.loading = false

            }, 1500)
        },
        formReset() {
            this.$refs.form.reset()
            for (const key in this.params.user) {
                this.params.user[key] = ''
            }
        }
    },
}
</script>