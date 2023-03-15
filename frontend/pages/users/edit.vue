<template>
    <v-container>
        <div class="mt-8" />
        <v-card>
            <v-tabs
                v-model="tab"
                background-color="primary"
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
                            <v-form
                                v-model="isValidProfile"
                            >
                                <v-row
                                    no-gutters
                                >
                                    <v-col
                                        cols="12" sm="3" md="3" lg="3" xl="3"
                                    >
                                        <div
                                            class="d-flex justify-center"
                                        >
                                            <div class="mt-15">
                                                <div v-if="preview.url">
                                                    <AvatarImg
                                                        :avatar-url="preview.url"
                                                        :size="48"
                                                        :xs-size="48"
                                                    />
                                                </div>
                                                <div v-else>
                                                    <AvatarImg
                                                        :avatar-url="avatar.url"
                                                        :size="48"
                                                        :xs-size="48"
                                                    />
                                                </div>
                                            </div>
                                            <div class="mt-5 text-center">
                                                <div v-if="preview.url && preview.flg">
                                                    <div class="mb-auto">
                                                        <v-btn
                                                            icon
                                                            dark
                                                            color="black"
                                                            @click="deletePreview"
                                                        >
                                                            <v-icon>mdi-alpha-x-circle</v-icon>
                                                        </v-btn>
                                                    </div>
                                                </div>
                                                <div v-if="!preview.flg">
                                                    <v-file-input
                                                        v-model="imgFile"
                                                        hide-input
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
                                                color="primary"
                                                small
                                                :loading="updateAvatarLoading"
                                                @click="updateAvatar"
                                            >
                                                画像変更
                                            </v-btn>
                                        </div>
                                    </v-col>
                                    <v-col
                                        cols="12" sm="9" md="9" lg="9" xl="9"
                                    >
                                        <v-text-field
                                            v-model="user.nickname"
                                            :rules="nicknameRules"
                                            :counter="max"
                                            label="ニックネーム"
                                            required
                                        >
                                        </v-text-field>
                                        <v-textarea
                                            v-model="user.introduction"
                                            name="input-7-1"
                                            label="自己紹介"
                                            hint="自己紹介文"
                                            auto-grow
                                            counter="256"
                                        >
                                        </v-textarea>
                                    </v-col>
                                </v-row>
                                <div class="mt-8" />
                                <v-card
                                    max-width="400"
                                    class="mx-auto"
                                    color="transparent"
                                    flat
                                >
                                    <div class="mb-8">
                                        <v-menu
                                            ref="menu"
                                            v-model="menu"
                                            :close-on-content-click="false"
                                            transition="scale-transition"
                                            offset-y
                                            min-width="auto"
                                        >
                                            <template #activator="{ on, attrs }">
                                                <v-text-field
                                                    v-model="user.birthday"
                                                    label="Birthday date"
                                                    prepend-icon="mdi-calendar"
                                                    readonly
                                                    v-bind="attrs"
                                                    v-on="on"
                                                >
                                                </v-text-field>
                                            </template>
                                            <v-date-picker
                                                v-model="user.birthday"
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
                                    <v-btn
                                        :disabled="!isValidProfile || profileLoading"
                                        :loading="profileLoading"
                                        color="primary"
                                        class="white--text mr-4"
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
                            <v-form v-model="isValidEmail">
                                <!-- <v-text-field
                                    v-model="email"
                                    label="E-mail"
                                    required
                                >
                                </v-text-field> -->
                                <user-form-email
                                    :email.sync="email"
                                />
                                <div
                                    class="d-flex justify-end"
                                >
                                    <v-btn
                                        :disabled="!isValidEmail || EmailLoading"
                                        :loading="EmailLoading"
                                        color="primary"
                                        class="white--text mr-4"
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
                            <v-form v-model="isValidPassword">
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
                                        :disabled="!isValidPassword || passwordLoading"
                                        :loading="passwordLoading"
                                        color="primary"
                                        class="white--text mr-4"
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
    </v-container>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import UserFormEmail from '~/components/Atom/UserForm/UserFormEmail.vue'
import UserFormPassword from '~/components/Atom/UserForm/UserFormPassword'
import UserFormPasswordAgain from '~/components/Atom/UserForm/UserFormPasswordAgain'
import AvatarImg from '~/components/Atom/App/AppAvatarImg.vue'

export default {
    name: 'UsersEdit',
    components: {
        UserFormEmail,
        UserFormPassword,
        UserFormPasswordAgain,
        AvatarImg,
    },
    async asyncData({ $axios, store}) {
        const res = await $axios.$get('/api/v1/users/edit')
        console.log(res)
        return {
            user: {
                id: res.id,
                nickname: res.nickname,
                introduction: res.introduction,
                birthday: res.birthday
            },
            avatar: res.avatar,
            email: res.email,
        }
    },
    data() {
        const max = 30;
        return {
            tab: null,
            activePicker: null,
            menu: false,
            user: {
                id: '',
                nickname: '',
                introduction: '',
                birthday: ''
            },
            avatar: {},
            email: '',
            password: '',
            passwordAgain: '',
            preview: {
                img: {},
                flg: false,
                url: ''
            },
            imgFile: {},
            updateAvatarLoading: false,
            isValidProfile: false,
            profileLoading: false,
            isValidEmail: false,
            EmailLoading: false,
            isValidPassword: false,
            passwordLoading: false,
            max,
            nicknameRules: [
                // 入力必須
                // v => 正しい式 || 'エラーメッセージ'
                v => !!v || '',
                // 30文字まで
                v => (!!v && max >= v.length) || `${max}文字以内で入力してください`
            ],
        }
    },
    computed: {
        ...mapGetters({
            currentUser: 'modules/user/getUser',
        }),
    },
    watch: {
        menu (val) {
            val && setTimeout(() => (this.activePicker = 'YEAR'))
        },
    },
    // beforeDestroy () {
    //     this.resetVuex()
    // },
    methods: {
        ...mapActions({
            dispatchToast: 'modules/toast/getToast',
            dispatchCurrentUser: 'modules/user/getCurrentUser',
        }),
        async updateProfile() {
            if( !this.isValidProfile || !this.user.nickname) {
                this.dispatchToast({
                        status: true,
                        msg: 'ニックネームは必須です',
                        color: 'error'
                })
            }
            this.profileLoading = true
            await this.$axios.$patch('/api/v1/users', this.user )
                .then(res => {
                    this.dispatchCurrentUser({
                        id: this.currentUser.id,
                        nickname: this.user.nickname,
                        avatar: this.currentUser.avatar,
                        admin: this.currentUser.admin,
                        sub: this.currentUser.sub,
                    })
                    this.dispatchToast({
                        status: true,
                        msg: 'プロフィールを更新しました',
                        color: 'info'
                    })

                })
                .catch(err => {
                    console.log(err)
                    this.dispatchToast({
                        status: true,
                        msg: '更新に失敗しました',
                        color: 'error'
                    })
                })
            this.profileLoading = false
        },
        save (date) {
            this.$refs.menu.save(date)
        },
        // resetVuex() {
        //     this.$store.dispatch('modules/toast/getToast',{
        //         status: false,
        //         msg: null,
        //         color: null,
        //     })
        // },
        async updateEmail() {
            if(!this.isValidEmail || !this.email) {
                this.dispatchToast({
                        status: true,
                        msg: 'Emailは必須です',
                        color: 'error'
                })
            }
            this.EmailLoading = true
            const params = {
                user: {
                    email: this.email,
                }
            }
            await this.$axios.$patch('/api/v1/auth_token/update_email', params)
                .then(res => {
                    this.$auth.login(res)
                    this.dispatchToast({
                        status: true,
                        msg: 'メールアドレスの更新しました',
                        color: 'info'
                    })
                })
                .catch( err => {
                    console.log(err)
                    this.dispatchToast({
                        status: true,
                        msg: 'メールアドレスの更新に失敗しました',
                        color: 'error'
                    })
                })
            this.EmailLoading = false
        },
        async updatePassword() {
            if(!this.isValidPassword) {
                return this.dispatchToast({
                        status: true,
                        msg: 'パスワードとは必須です',
                        color: 'error'
                })
            }
            const password = this.password
            if(password !== this.passwordAgain) {
                return this.dispatchToast({
                        status: true,
                        msg: 'パスワードと確認用パスワードが一致しません',
                        color: 'error'
                })
            }
            this.passwordLoading = true
            const params = {
                user: {
                    password,
                }
            }
            await this.$axios.$patch('/api/v1/auth_token/update_password',params)
                .then(res => {
                    console.log(res)
                    this.$auth.login(res)
                    this.dispatchToast({
                        status: true,
                        msg: 'パスワードの更新しました',
                        color: 'info'
                    })
                })
                .catch( err => {
                    console.log(err)
                    this.dispatchToast({
                        status: true,
                        msg: 'パスワードの更新に失敗しました',
                        color: 'error'
                })
                })
            this.passwordLoading = false
        },
        fileChange() {
            this.preview.flg = true
            this.preview.img = this.imgFile
            this.preview.url = window.URL.createObjectURL(this.imgFile)
        },
        async updateAvatar() {
            if(!this.preview.flg) {
                return this.dispatchToast({
                        status: true,
                        msg: 'アイコンが更新されてません',
                        color: 'error'
                })
            }
            this.updateAvatarLoading = true
            const formData = new FormData()
            formData.append('user[avatar]', this.preview.img)
            await this.$axios.$patch('/api/v1/users/update_avatar', formData)
                .then(res => {
                    this.dispatchCurrentUser({
                        id: this.currentUser.id,
                        nickname: this.currentUser.nickname,
                        avatar: res.avatar,
                        admin: this.currentUser.admin,
                        sub: this.currentUser.sub,

                    })
                    this.avatar = res.avatar
                    this.preview.flg = false
                    this.preview.url = null
                    this.preview.img = {}
                    this.dispatchToast({
                        status: true,
                        msg: 'アイコンを更新しました',
                        color: 'info'
                    })
                })
                .catch( err => {
                    console.log(err)
                    this.dispatchToast({
                        status: true,
                        msg: 'アイコンの更新に失敗しました',
                        color: 'error'
                    })
                })
            this.updateAvatarLoading = false
        },
        deletePreview() {
            this.preview = {url: null,flg: false, img: {}}
        }
    },
}
</script>