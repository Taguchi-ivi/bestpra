<template>
    <user-form-card >
        <template #user-form-card-content>
            <v-form
                v-model="isValid"
                >
                <!-- .sync => @input="name = $event" -->
                <user-form-name
                    :name.sync="params.user.name"
                />
                name => {{ params.user.name }}
                <user-form-email
                    :email.sync="params.user.email"
                />
                name => {{ params.user.email }}
                <user-form-password
                    :password.sync="params.user.password"
                />
                name => {{ params.user.password }}
                <v-btn
                    :disabled="!isValid"
                    block
                    class="white--text"
                    color="blue"
                >
                    登録
                </v-btn>
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
            params: {user: { name: '', email: '', password: ''} }
        }
    }
}
</script>