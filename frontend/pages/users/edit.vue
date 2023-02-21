<template>
    <v-container>
        <div class="mt-8" />
        <v-card>
            <v-tabs
                v-model="tab"
                background-color="indigo"
                centered
                dark
                icons-and-text
            >
            <v-tabs-slider></v-tabs-slider>

            <v-tab href="#tab-1">
                プロフィール
                <v-icon>mdi-account-edit</v-icon>
            </v-tab>

            <v-tab href="#tab-2">
                メールアドレス
                <v-icon>mdi-email-edit-outline</v-icon>
            </v-tab>

            <v-tab href="#tab-3">
                パスワード
                <v-icon>mdi-key-variant</v-icon>
            </v-tab>
            </v-tabs>

            <v-tabs-items v-model="tab">
                <v-card
                    flat
                >
                    <v-card
                        class="mx-auto"
                        max-width="800"
                        color="transparent"
                        flat
                    >
                        <v-tab-item
                            :value="tab-1"
                        >
                            <v-form>
                                <v-row
                                    no-gutters
                                >
                                    <v-col
                                        cols="3"
                                        class="d-flex"
                                    >
                                        <div v-if="avatar.url">
                                            <v-img
                                                :src="avatar.img"
                                            >

                                            </v-img>
                                        </div>
                                        <v-avatar
                                            color="indigo"
                                            class="align-self-center"
                                            >
                                            <v-icon dark>
                                                mdi-account-circle
                                            </v-icon>
                                        </v-avatar>
                                    </v-col>
                                    <v-col
                                        cols="9"
                                    >
                                        <!-- v-model="nickname" -->
                                        <!-- :rules="nameRules" -->
                                        <v-text-field
                                            v-model="user.nickname"
                                            color="indigo"
                                            :counter="20"
                                            label="ニックネーム"
                                            required
                                        >
                                        </v-text-field>
                                        <v-textarea
                                            v-model="user.ntroduction"
                                            color="indigo"
                                            name="input-7-1"
                                            label="自己紹介"
                                            hint="自己紹介文"
                                            auto-grow
                                            counter="256"
                                        >
                                        </v-textarea>
                                    </v-col>
                                </v-row>
                                <!-- :rules="emailRules" -->
                                <!-- v-model="email" -->
                                <div class="mt-8" />
                                <v-card
                                    max-width="400"
                                    class="mx-auto"
                                    color="transparent"
                                    flat
                                >
                                    <div class="mb-8">
                                        <!-- <div class="mb-6">
                                            Active picker: <code>{{ activePicker || 'null' }}</code>
                                        </div> -->
                                        <v-menu
                                            ref="menu"
                                            v-model="menu"
                                            :close-on-content-click="false"
                                            transition="scale-transition"
                                            offset-y
                                            min-width="auto"
                                        >
                                            <template #activator="{ on, attrs }">
                                                <!-- v-model="date" -->
                                                <!-- :value="birthday" -->
                                                <v-text-field
                                                    v-model="user.birthday"
                                                    color="indigo"
                                                    label="Birthday date"
                                                    prepend-icon="mdi-calendar"
                                                    readonly
                                                    v-bind="attrs"
                                                    v-on="on"
                                                >
                                                </v-text-field>
                                            </template>
                                            <!-- v-model="date" -->
                                            <v-date-picker
                                                v-model="user.birthday"
                                                color="indigo"
                                                :active-picker.sync="activePicker"
                                                :max="(new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString().substr(0, 10)"
                                                min="1950-01-01"
                                                @change="save"
                                            >
                                            </v-date-picker>
                                        </v-menu>
                                    </div>
                                    <!-- <v-text-field
                                        v-model="user.email"
                                        color="indigo"
                                        label="E-mail"
                                        required
                                    >
                                    </v-text-field> -->
                                </v-card>
                                <div
                                    class="d-flex justify-end"
                                >
                                <!-- :disabled="!valid" -->
                                    <v-btn
                                        dark
                                        color="indigo"
                                        class="mr-4"
                                        @click="updateProfile"
                                    >
                                        保存
                                    </v-btn>
                                </div>
                            </v-form>
                        </v-tab-item>
                        <v-tab-item
                            :value="tab-2"
                        >
                            <!-- <v-card flat> -->
                            <div>{{ text + "b" }}</div>
                                <v-form>
                                    <v-text-field
                                        v-model="email"
                                        color="indigo"
                                        label="E-mail"
                                        required
                                    >
                                    </v-text-field>
                                    <div
                                        class="d-flex justify-end"
                                    >
                                    <!-- :disabled="!valid" -->
                                        <v-btn
                                            dark
                                            color="indigo"
                                            class="mr-4"
                                            @click="updateEmail"
                                        >
                                            保存
                                        </v-btn>
                                    </div>
                                </v-form>
                            <!-- </v-card> -->
                        </v-tab-item>
                        <v-tab-item
                            :value="tab-3"
                        >
                            <v-card flat>
                                <v-card-text>{{ text + "c" }}</v-card-text>
                            </v-card>
                            <v-form>
                                <user-form-password
                                    :password.sync="params.user.password"
                                    set-validation
                                />
                                <user-form-password-again
                                    :password-again.sync="passwordAgain"
                                />
                                <v-btn
                                    dark
                                    color="indigo"
                                    class="mr-4"
                                    @click="updatePassword"
                                >
                                    保存
                                </v-btn>
                            </v-form>
                        </v-tab-item>
                        <!-- <v-tab-item
                            v-for="i in 3"
                            :key="i"
                            :value="'tab-' + i"
                        >
                            <v-card flat>
                            <v-card-text>{{ text }}</v-card-text>
                            </v-card>
                        </v-tab-item> -->
                    </v-card>
                </v-card>
            </v-tabs-items>
        </v-card>

        <!-- <v-form v-model="valid"> -->
    </v-container>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
    async asyncData({ $axios,store }) {
        // const editUser = store.getters['modules/user/getEditUser']
        await $axios.$get('api/v1/users/edit')
        // await $axios.$get(`api/v1/users/`)
            .then(res => {
                console.log(res)
                // store.dispatch('modules/user/getEditUser', res)
                return {
                    user: {
                        nickname: res.nickname,
                        introduction: res.introduction,
                        birthday: res.birthday
                    },
                    avatar: res.avatar,
                    email: res.email,
                    password: res.password,
                }
            })
            .catch(err => {
                console.log(err)
            })
    },
    data() {
        return {
            tab: null,
            text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit,',
            // date: null,
            activePicker: null,
            menu: false,
            user: {
                id: '',
                nickname: '',
                introduction: '',
                birthday: ''
            },
            avatar: [],
            email: '',
            params: {
                user: {
                    password: '',
                }
            },
            passwordAgain: ''
        }
    },
    computed: {
        ...mapGetters({
            currentUser: 'modules/user/getUser',
            editUser: 'modules/user/getEditUser',
        }),
        dateFormat() {
            // date => birthday
            return (birthday) => {
                const dateTimeFormat = new Intl.DateTimeFormat(
                    'ja', { dateStyle: 'medium', timeStyle: 'short'}
                )
                return dateTimeFormat.format(new Date(birthday))
            }
        }
    },
    watch: {
        menu (val) {
            val && setTimeout(() => (this.activePicker = 'YEAR'))
        },
    },
    methods: {
        async updateProfile() {
            await this.$axios.$patch('api/v1/users/update', this.user)
                .then(res => {
                    console.log(res)
                    const status = true
                    const msg = 'プロフィールを更新しました'
                    const color = 'info'
                    this.$store.dispatch('modules/toast/getToast', { status, msg, color })
                })
                .catch(err => {
                    console.log(err)
                })
        },
        save (date) {
            this.$refs.menu.save(date)
        },
        resetEditUser() {
            return this.$store.dispatch('modules/user/getEditUser', null)
        },
        async updateEmail() {
            await this.$axios.$patch('api/v1/auth_token/update_email',{
                    params: {
                        user: {
                            email: this.email
                        }
                    }})
                .then(res => {
                    console.log(res)
                    this.$auth.login(res)
                    const status = true
                    const msg = 'メールアドレスの更新しました'
                    const color = 'info'
                    this.$store.dispatch('modules/toast/getToast', { status, msg, color })
                })
                .catch( err => {
                    console.log(err)
                    const status = true
                    const msg = 'メールアドレスの更新に失敗しました'
                    this.$store.dispatch('modules/toast/getToast', { status, msg })
                })
        },
        async updatePassword() {
            const password = this.params.user.password
            if(password !== this.passwordAgain) {
                const status = true
                const msg = 'パスワードと確認用パスワードが一致しません'
                return this.$store.dispatch('modules/toast/getToast', { status, msg })
            }
            await this.$axios.$patch('api/v1/auth_token/update_password',{
                    params: {
                        user: {
                            password: this.email
                        }
                    }})
                .then(res => {
                    console.log(res)
                    this.$auth.login(res)
                    const status = true
                    const msg = 'パスワードの更新しました'
                    const color = 'info'
                    this.$store.dispatch('modules/toast/getToast', { status, msg, color })
                })
                .catch( err => {
                    console.log(err)
                    const status = true
                    const msg = 'パスワードの更新に失敗しました'
                    this.$store.dispatch('modules/toast/getToast', { status, msg })
                })
        }
    },
    beforeDestroy () {
        // Vueインスタンスが破棄される直前にVuexのtoast.msgを削除する(無期限toastに対応)
        this.resetEditUser()
    },
}
</script>