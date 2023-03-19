<template>
    <div>
        <div v-if="error">
            <ErrorCard
                title="存在しないページです"
                message="404 not found"
            />
        </div>
        <div v-if="!error">
            <div class="pa-5">
                <div class="d-flex justify-center">
                    <div>
                        <AvatarImg
                            :avatar-url="otherUser.avatar.url"
                            :size="60"
                            :xs-size="48"
                        />
                        <p>{{ otherUser.nickname }}</p>
                    </div>
                    <div class="ml-4">
                        <div v-if="$my.isCurrentUser(otherUser.id)">
                            <v-menu
                                app
                                offset-x
                                offset-y
                                max-width="300"
                            >
                                <template
                                    #activator="{ on }"
                                >
                                    <v-btn
                                        icon
                                        v-on="on"
                                    >
                                        <v-icon :size="$vuetify.breakpoint.xs ? 15 : 20">
                                            mdi-cog-outline
                                        </v-icon>
                                    </v-btn>
                                </template>
                                <v-list
                                    dense
                                >
                                    <v-subheader>
                                        アカウント
                                    </v-subheader>
                                    <v-list-item
                                        to="/users/edit"
                                    >
                                        <v-list-item-icon
                                            class="mr-2"
                                        >
                                            <v-icon size="22">
                                                mdi-account-edit
                                            </v-icon>
                                        </v-list-item-icon>
                                        <v-list-item-title>
                                            編集する
                                        </v-list-item-title>
                                    </v-list-item>
                                    <v-dialog
                                        v-model="dialog"
                                        max-width="290"
                                    >
                                        <template #activator="{ on, attrs }">
                                            <v-list-item
                                                v-bind="attrs"
                                                v-on="on"
                                            >
                                                <v-list-item-icon
                                                    class="mr-2"
                                                >
                                                    <v-icon
                                                        size="22"
                                                    >
                                                        mdi-account-remove
                                                    </v-icon>
                                                </v-list-item-icon>
                                                <v-list-item-title>
                                                    削除する
                                                </v-list-item-title>
                                            </v-list-item>
                                        </template>
                                        <v-card>
                                            <v-card-title class="text-h5">
                                                アカウント削除
                                            </v-card-title>
                                            <v-card-text>
                                                全てのデータが削除されます<br />
                                                本当によろしいですか？
                                            </v-card-text>
                                            <v-card-actions>
                                            <v-spacer />
                                            <v-btn
                                                color="blue"
                                                text
                                                @click="dialog = false"
                                            >
                                                キャンセル
                                            </v-btn>
                                            <v-btn
                                                color="red"
                                                text
                                                @click="accountDelete"
                                            >
                                                削除する
                                            </v-btn>
                                            </v-card-actions>
                                        </v-card>
                                    </v-dialog>
                                </v-list>
                            </v-menu>
                        </div>
                        <div v-else>
                            <v-btn
                                v-if="$my.isFollowed(otherUser.id)"
                                color="white--text red"
                                :small="$vuetify.breakpoint.xs ? true : false"
                                @click="unfollow"
                            >
                                フォロー解除
                            </v-btn>
                            <v-btn
                                v-else
                                color="primary"
                                :small="$vuetify.breakpoint.xs ? true : false"
                                @click="follow"
                            >
                                フォローする
                            </v-btn>
                        </div>
                    </div>
                </div>
                <v-card
                    max-width="500"
                    class="mx-auto pa-3"
                    color="light-blue lighten-5"
                    flat
                >
                    <div v-if="otherUser.introduction">
                        {{ otherUser.introduction }}
                    </div>
                    <div v-else>
                        自己紹介はありません
                    </div>
                </v-card>
                <div class="mx-auto mt-3" style="max-width: 500px;">
                    <div class="d-flex justify-space-around">
                        <div>
                            <p class="mb-0 text-center text-caption">
                                <nuxt-link :to="`/users/${otherUser.id}/articles`">{{ otherUser.articles }}</nuxt-link>
                            </p>
                            <p>menus</p>
                        </div>
                        <div>
                            <p class="mb-0 text-center text-caption">
                                <nuxt-link :to="`/users/${otherUser.id}/following`">{{ otherUser.following }}</nuxt-link>
                            </p>
                            <p>following</p>
                        </div>
                        <div>
                            <p class="mb-0 text-center text-caption">
                                <nuxt-link :to="`/users/${otherUser.id}/followers`">{{ otherUser.followers }}</nuxt-link>
                            </p>
                            <p>follower</p>
                        </div>
                </div>
                </div>
            </div>
            <div
                style="width: 97%"
                class="mx-auto"
            >
                <v-divider />
            </div>
            <v-container
                fluid
                class="mt-5"
                >
                <v-row no-gutters>
                    <v-col
                        cols="12" sm="3" md="3" lg="3" xl="3"
                    >
                        <v-list
                            rounded
                            color="transparent"
                            max-width="250"
                            :class="$vuetify.breakpoint.xs ? 'mx-auto' : 'toc-view'"
                        >
                            <v-list-item-group
                                v-model="model"
                                mandatory
                                color="primary"
                            >
                                <v-row>
                                    <v-col
                                        v-for="(item, i) in items"
                                        :key="i"
                                        cols="4" sm="12" md="12" lg="12" xl="12"
                                    >
                                        <v-list-item
                                            :to="item.path" nuxt
                                        >
                                            <v-list-item-icon>
                                                <v-icon>
                                                    {{ item.icon }}
                                                </v-icon>
                                            </v-list-item-icon>
                                            <v-list-item-content>
                                                <v-list-item-title>
                                                    {{ item.text }}
                                                </v-list-item-title>
                                            </v-list-item-content>
                                        </v-list-item>
                                    </v-col>
                                </v-row>
                            </v-list-item-group>
                        </v-list>
                    </v-col>
                    <v-col
                        cols="12" sm="9" md="9" lg="9" xl="9"
                    >
                        <div v-if="$route.name === 'users-id'">
                            <div v-if="$my.isCurrentUser(otherUser.id)">
                                <p class="text-center">おかえりなさい</p>
                            </div>
                            <div v-else>
                                <p class="text-center">WellCome to {{ otherUser.nickname }}page</p>
                            </div>
                        </div>
                        <nuxt-child />
                    </v-col>
                </v-row>
            </v-container>
        </div>
    </div>
</template>

<script>

import { mapGetters, mapMutations } from 'vuex'
import ErrorCard from '~/components/Molecules/ErrorCard.vue'
import AvatarImg from '~/components/Atom/App/AppAvatarImg.vue'

export default {
    name: 'UsersProfile',
    components: {
        ErrorCard,
        AvatarImg,
    },
    async asyncData({$axios, $my, params, store, route}) {
        const res = await $axios.$get(`/api/v1/users/${params.id}`)
        if(res === 'bad_request') {
            store.dispatch('modules/toast/getToast', {
                        status: true,
                        msg: '存在しない練習メニュです',
                        color: 'error'
                    })
            return {
                error: true
            }
        }
        const path = route.path
        const pathArray = path.split('/')
        const routeName = pathArray[pathArray.length -1]
        if(routeName === 'notifications' && !$my.isCurrentUser(params.id)) {
            return {
                error: true,
            }
        }
        const items = [
                    {icon: 'mdi-note', text: '練習メニュー', path: `/users/${params.id}/articles`},
                    {icon: 'mdi-account-star', text: 'フォロー', path: `/users/${params.id}/following`},
                    {icon: 'mdi-account-star-outline', text: 'フォロワー', path: `/users/${params.id}/followers`},
                    {icon: 'mdi-heart', text: 'いいね', path: `/users/${params.id}/likes`},
                ]
        store.dispatch('modules/user/getOtherUser', res)
        if($my.isCurrentUser(params.id)) {
            items.push(
                {icon: 'mdi-bell-outline', text: '通知', path: `/users/${params.id}/notifications`}
            )
            return {
                error: false,
                items
            }
        } else {
            return {
                error: false,
                items
            }
        }
    },
    data() {
        return {
            on: false,
            dialog: false,
            model: 0,
        }
    },
    head(){
        return {
            title: 'Profile Page',
        }
    },
    computed: {
        ...mapGetters({
            currentUser: 'modules/user/getUser',
            otherUser: 'modules/user/getOtherUser',
            followingUsers: 'modules/follow/getCurrentFollow',
        }),
    },
    methods: {
        ...mapMutations({
            commitCreateFollow: 'modules/follow/setCreateCurrentFollow',
            commitDeleteFollow: 'modules/follow/setDeleteCurrentFollow',
            commitFollowUser: 'modules/user/setFollowOtherUser',
            commiUnfollowUser: 'modules/user/setUnfollowOtherUser',
            commitCreateFollower: 'modules/follow/setCreateOtherFollower',
            commitDeleteFollower: 'modules/follow/setDeleteOtherFollower',
        }),
        // Vuexのtoast.msgの値を変更する
        // resetOtherUser() {
        //     // return this.$store.dispatch('modules/user/getOtherUser', null)
        // },
        async accountDelete() {
            await this.$axios.$delete(`/api/v1/auth_token/${this.otherUser.id}`,{})
                .then(res => {
                    // this.$my.dispatchToast(true, '削除が完了しました', 'success')
                    this.$router.push('/about')
                    this.$auth.resetVuex()
                })
                .catch( err => {
                    console.log(err)
                    this.$my.dispatchToast(true, 'アカウト削除に失敗しました', 'error')
                })
            this.dialog = false
        },
        async follow() {
            await this.$axios.$post(`/api/v1/users/${this.$route.params.id}/relationships`)
                .then(res => {
                    this.commitCreateFollow(this.$route.params.id)
                    this.commitFollowUser()
                    this.commitCreateFollower({
                        id: this.currentUser.id,
                        nickname: this.currentUser.nickname,
                        introduction: this.currentUser.introduction,
                        avatar: {
                            url: this.currentUser.avatar.url,
                        },
                    })
                })
                .catch( err => {
                    console.log(err)
                })
        },
        async unfollow() {
            await this.$axios.$post(`/api/v1/users/${this.$route.params.id}/relationships/unfollow`)
                .then(res => {
                    this.commitDeleteFollow(this.$route.params.id)
                    this.commiUnfollowUser()
                    this.commitDeleteFollower(this.currentUser.id)
                })
                .catch( err => {
                    console.log(err)
                })
        },
        activeBell(name, userId) {
            let result = false
            if (name === '通知') {
                result = this.currentUser.id === userId
            } else {
                result = true
            }
            return result
        }
    },
    // idページからidページへ遷移(nuxt-link)するとエラーになるため、コメントアウト
    // async beforeDestroy () {
    //     // Vueインスタンスが破棄される直前にVuexのtoast.msgを削除する(無期限toastに対応)
    //     await this.resetOtherUser()
    // },
}
</script>