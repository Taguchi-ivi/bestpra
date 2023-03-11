<template>
    <div>
        <MainTitle
            title="通知一覧"
        />
        <v-card
            width="80%"
            class="mx-auto pa-3"
            elevation="8"
        >
        <!-- three-line -->
            <v-list
            >
                <div
                    v-for="(notification, index) in notifications"
                    :key="index"
                >
                <!-- TODO  ここから下いらない -->
                <!-- notification -->
                <!-- 配列の最後の要素だけdividerFlgをfalseに -->
                <NotificationMain
                    :notification="notification"
                    :divider-flg="index + 1 !== notifications.length"
                />
                    <!-- <v-list-item>
                        {{notification}}
                    </v-list-item> -->
                </div>
            </v-list>
        </v-card>
    </div>
</template>

<script>
import { mapMutations } from 'vuex'
import MainTitle from '~/components/Atom/App/AppMainTitle.vue'
import NotificationMain from '~/components/Molecules/NotificationMain.vue'

export default {
    components: {
        MainTitle,
        NotificationMain
    },
    async asyncData({ $axios, $my, params ,store }) {
        // const user = store.getters['modules/user/getUser']
        // console.log('user', user.id)
        // console.log('params', params.id)
        if ($my.isCurrentUser(params.id)) {
            const res = await $axios.$get('/api/v1/notifications')
            return {
                error: false,
                notifications: res
            }
        } else {
            store.dispatch('modules/toast/getToast', {
                            status: true,
                            msg: '存在しないユーザーです',
                            color: 'error'
                        })
            return {
                error: true,
                notifications: []
            }
        }
    },
    mounted() {
        if (this.$my.isCurrentUser(this.$route.params.id)) {
            this.updateNotification()
        }
    },
    methods: {
        ...mapMutations({
            commitHeaderUpdate: 'modules/notification/setNotificationHeaderAllUpdate',
        }),
        // 通知の設定
        async updateNotification() {
            this.commitHeaderUpdate()
            await this.$axios.$patch('/api/v1/notifications/all_update')
                .then(res => {
                    console.log(res)
                })
                .catch(err => {
                    console.log(err)
                })
        }
    },
}
</script>