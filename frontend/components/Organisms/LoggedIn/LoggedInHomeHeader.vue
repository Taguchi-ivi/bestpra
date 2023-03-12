<template>
    <v-app-bar
        fixed
    >
        <slot name="navigation-toggle-button" />
        <!-- <nuxt-link to="/about"> -->
        <nuxt-link to="/home/all">
            <v-img width="50" src="/header-logo.png"></v-img>
        </nuxt-link>
        <v-toolbar-title class="ml-3 hidden-mobile-and-down">bestpra</v-toolbar-title>

        <v-spacer />

        <div>
            <v-menu
                app
                offset-x
                offset-y
                max-width="300"
            >
                <template
                    #activator="{ on }"
                >
                    <!-- TODO switch -->
                    <v-badge
                        :value="activeBell()"
                        dot
                        offset-x="20"
                        offset-y="20"
                        color="pink"
                    >
                        <v-btn
                            icon
                            v-on="on"
                        >
                            <v-icon
                                size="30"
                            >
                                mdi-bell-outline
                            </v-icon>
                        </v-btn>
                    </v-badge>
                </template>
                <!-- three-line -->
                <v-list
                >
                <div v-if="notificationHeader.length === 0">
                    <v-list-item>
                        <v-list-item-content>
                            また通知はありません
                        </v-list-item-content>
                    </v-list-item>
                </div>
                <div v-else>
                    <div
                        v-for="(notification, index) in notificationHeader"
                        :key="index"
                    >
                    <!-- TODO  ここから下いらない -->
                    <!-- notification -->
                    <!-- 配列の最後の要素だけdividerFlgをfalseに -->
                        <NotificationMain
                            header-flg
                            :notification="notification"
                        />
                        <!-- :divider-flg="index + 1 !== notificationHeader.length" -->
                        <!-- <v-list-item>
                            {{notification}}
                        </v-list-item> -->
                        <!-- <v-divider /> -->
                    </div>
                    <v-list-item
                        class="pa-2"
                        :to="`/users/${$auth.user.id}/notifications`" nuxt
                    >
                    <div
                        class="mx-auto"
                    >
                        通知一覧へ
                        <v-icon>
                            mdi-chevron-double-right
                        </v-icon>
                    </div>
                    </v-list-item>
                </div>
                </v-list>
            </v-menu>
        </div>

        <AvatarSwitch
            :id="Number($auth.user.id)"
            header-flg
            :size="33"
            :avatar-url="$auth.user.avatar.url"
        />
    </v-app-bar>
</template>

<script>

import { mapGetters } from 'vuex'
import AvatarSwitch from '~/components/Molecules/AvatarSwitch.vue'
import NotificationMain from '~/components/Molecules/NotificationMain.vue'

export default {
    components: {
        AvatarSwitch,
        NotificationMain
    },
    data() {
        return {
            on: false,
        }
    },
    computed: {
        ...mapGetters({
            notificationHeader: 'modules/notification/getNotificationHeader',
        }),
    },
    methods: {
        activeBell() {
            // return Object.values(this.notificationHeader).includes(true)
            for(const item of this.notificationHeader) {
                if(Object.prototype.hasOwnProperty.call(item,'checked') && item.checked === false) {
                    return true
                }
            }
            return false
        }
    }
}
</script>