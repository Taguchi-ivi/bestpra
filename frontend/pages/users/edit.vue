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
                <v-tab-item
                    value="tab-1"
                >
                    <v-card
                        flat
                    >
                        <v-card
                            class="mx-auto pa-5"
                            max-width="800"
                            color="transparent"
                            flat
                        >
                            <v-form>
                                <v-row
                                    no-gutters
                                >
                                    <v-col
                                        cols="3"
                                    >
                                        <!-- <v-form> -->
                                        <div
                                            class="d-flex justify-center"
                                        >
                                        <!-- TODO avatarComponentsに集約できるか検証必要 -->
                                            <div v-if="avatar.url">
                                                <v-img
                                                    :src="preview.url ? preview.url : avatar.url"
                                                >
                                                </v-img>
                                            </div>
                                            <!-- class="align-self-center" -->
                                            <div v-else class="mt-15">
                                                <!-- <v-avatar
                                                    color="indigo"
                                                >
                                                    <v-icon dark>
                                                        mdi-account-circle
                                                    </v-icon>
                                                </v-avatar> -->
                                                <AvatarImg
                                                    :avatar="avatar"
                                                />
                                            </div>
                                            <div class="mt-5 text-center">
                                                <!-- <v-btn
                                                    outlined
                                                    dark
                                                    color="indigo"
                                                    small
                                                    @click="updateAvatar"
                                                >
                                                    画像変更
                                                </v-btn> -->
                                                <div v-if="preview.url && preview.flg">
                                                    <v-btn
                                                        icon
                                                        dark
                                                        color="black"
                                                        @click="deletePreview"
                                                    >
                                                        <v-icon>x</v-icon>
                                                    </v-btn>
                                                </div>
                                                <div v-if="!preview.flg">
                                                    <v-file-input
                                                        v-model="imgFile"
                                                        hide-input
                                                        small-chips
                                                        prepend-icon="mdi-image-plus"
                                                        @change="fileChange"
                                                    >
                                                    </v-file-input>
                                                </div>
                                            </div>
                                        </div>
                                        <div
                                            v-if="preview.flg"
                                            class="mt-5 text-center"
                                        >
                                            <v-btn
                                                outlined
                                                dark
                                                color="indigo"
                                                small
                                                :loading="updateAvatarLoading"
                                                @click="updateAvatar"
                                            >
                                                画像変更
                                            </v-btn>
                                        </div>
                                        <!-- </v-form> -->
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
                                            v-model="user.introduction"
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
                        </v-card>
                    </v-card>
                </v-tab-item>
                <v-tab-item
                    value="tab-2"
                >
                    <v-card
                        flat
                    >
                        <v-card
                            class="mx-auto pa-5"
                            max-width="800"
                            color="transparent"
                            flat
                        >
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
                        </v-card>
                    </v-card>
                </v-tab-item>
                <v-tab-item
                    value="tab-3"
                >
                    <v-card
                        flat
                    >
                        <v-card
                            class="mx-auto pa-5"
                            max-width="800"
                            color="transparent"
                            flat
                        >
                            <v-form>
                                <user-form-password
                                    :password.sync="password"
                                    set-validation
                                />
                                <user-form-password-again
                                    :password-again.sync="passwordAgain"
                                />
                                <div
                                    class="d-flex justify-end"
                                >
                                    <v-btn
                                        dark
                                        color="indigo"
                                        class="mr-4"
                                        @click="updatePassword"
                                    >
                                        保存
                                    </v-btn>
                                </div>
                            </v-form>
                        </v-card>
                    </v-card>
                </v-tab-item>
            </v-tabs-items>
        </v-card>

        <!-- <p>{{ user }}</p>
        <p>{{ 'email =>'  + email }}</p> -->

        <!-- <v-form v-model="valid"> -->
    </v-container>
</template>

<script>
import { mapGetters } from 'vuex'
import UserFormPassword from '~/components/Atom/UserForm/UserFormPassword'
import UserFormPasswordAgain from '~/components/Atom/UserForm/UserFormPasswordAgain'
import AvatarImg from '~/components/Atom/App/AppAvatarImg.vue'

export default {
    name: 'UsersEdit',
    async asyncData({ $axios,store }) {
        // const editUser = store.getters['modules/user/getEditUser']
        const res = await $axios.$get('api/v1/users/edit')
        // await $axios.$get(`api/v1/users/`)
        console.log(res)
        // store.dispatch('modules/user/getEditUser', res)
        return {
            user: {
                id: res.id,
                nickname: res.nickname,
                introduction: res.introduction,
                birthday: res.birthday
            },
            avatar: res.avatar,
            email: res.email,
            // password: res.password,
        }
    },
    components: {
        UserFormPassword,
        UserFormPasswordAgain,
        AvatarImg,
    },
    data() {
        return {
            tab: null,
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
            password: '',
            passwordAgain: '',
            preview: {
                url: '',
                flg: false
            },
            imgFile: {},
            updateAvatarLoading: false,
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
            console.log('ok')
            console.log(this.user)
            await this.$axios.$patch('/api/v1/users', this.user )
                .then(res => {
                    // console.log(res)
                    this.$store.dispatch('modules/user/getCurrentUser', {
                        id: this.currentUser.id,
                        nickname: this.user.nickname,
                        // introduction: this.user.introduction,
                        // birthday: this.user.birthday
                    })
                    // const status = true
                    // const msg = 'プロフィールを更新しました'
                    // const color = 'info'
                    // this.$store.dispatch('modules/toast/getToast', { status, msg, color })
                    this.$store.dispatch('modules/toast/getToast', {
                        status: true,
                        msg: 'プロフィールを更新しました',
                        color: 'info'
                    })
                })
                .catch(err => {
                    console.log(err)
                })
        },
        save (date) {
            this.$refs.menu.save(date)
        },
        resetVuex() {
            this.$store.dispatch('modules/toast/getToast',{
                status: false,
                msg: null,
                color: null,
            })
            return this.$store.dispatch('modules/user/getEditUser', null)
        },
        async updateEmail() {
            const params = {
                user: {
                    email: this.email,
                }
            }
            // console.log(this.email)
            await this.$axios.$patch('/api/v1/auth_token/update_email', params)
                .then(res => {
                    // console.log(res)
                    this.$auth.login(res)
                    // const status = true
                    // const msg = 'メールアドレスの更新しました'
                    // const color = 'info'
                    // this.$store.dispatch('modules/toast/getToast', { status, msg, color })
                    this.$store.dispatch('modules/toast/getToast', {
                        status: true,
                        msg: 'メールアドレスの更新しました',
                        color: 'info'
                    })
                })
                .catch( err => {
                    console.log(err)
                    // const status = true
                    // const msg = 'メールアドレスの更新に失敗しました'
                    // const color = 'error'
                    // this.$store.dispatch('modules/toast/getToast', { status, msg, color })
                    this.$store.dispatch('modules/toast/getToast', {
                        status: true,
                        msg: 'メールアドレスの更新に失敗しました',
                        color: 'error'
                    })
                })
        },
        async updatePassword() {
            const password = this.password
            if(password !== this.passwordAgain) {
                // const status = true
                // const msg = 'パスワードと確認用パスワードが一致しません'
                // const color = 'error'
                // return this.$store.dispatch('modules/toast/getToast', { status, msg, color })
                return this.$store.dispatch('modules/toast/getToast', {
                    status: true,
                    msg: 'パスワードと確認用パスワードが一致しません',
                    color: 'error'
                })
            }
            const params = {
                user: {
                    password,
                }
            }
            await this.$axios.$patch('/api/v1/auth_token/update_password',params)
                .then(res => {
                    console.log(res)
                    this.$auth.login(res)
                    // const status = true
                    // const msg = 'パスワードの更新しました'
                    // const color = 'info'
                    // this.$store.dispatch('modules/toast/getToast', { status, msg, color })
                    this.$store.dispatch('modules/toast/getToast', {
                        status: true,
                        msg: 'パスワードの更新しました',
                        color: 'info'
                    })
                })
                .catch( err => {
                    console.log(err)
                    // const status = true
                    // const msg = 'パスワードの更新に失敗しました'
                    // const color = 'error'
                    // this.$store.dispatch('modules/toast/getToast', { status, msg, color })
                    this.$store.dispatch('modules/toast/getToast', {
                        status: true,
                        msg: 'パスワードの更新に失敗しました',
                        color: 'error'
                    })
                })
        },
        fileChange() {
            console.log('これはimgFile',this.imgFile)
            this.preview.flg = true
            // this.preview.url = window.URL.createObjectURL(imgFile)
        },
        async updateAvatar() {
            this.updateAvatarLoading = true
            console.log(this.avatar)
            const params = {
                user: {
                    avatar: this.avatar
                }
            }
            await this.$axios.$patch('/api/v1/users/update_avatar',params)
                .then(res => {
                    console.log(res)
                    this.$auth.login(res)
                    // const status = true
                    // const msg = 'アイコンを更新しました'
                    // const color = 'info'
                    this.$store.dispatch('modules/toast/getToast', {
                        status: true,
                        msg: 'アイコンを更新しました',
                        color: 'info'
                    })
                })
                .catch( err => {
                    console.log(err)
                    // const status = true
                    // const msg = 'アイコンの更新に失敗しました'
                    // const color = 'error'
                    this.$store.dispatch('modules/toast/getToast',{
                        status: true,
                        msg: 'アイコンの更新に失敗しました',
                        color: 'error'
                    })
                })
            this.updateAvatarLoading = false
        },
        deletePreview() {
            this.preview = {url: '',flg: false}
        }
    },
    beforeDestroy () {
        this.resetVuex()
    },
}
</script>