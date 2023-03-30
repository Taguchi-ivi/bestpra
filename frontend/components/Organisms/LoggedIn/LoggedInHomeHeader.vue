<template>
    <v-app-bar
        fixed
        class="z-500"
    >
        <slot name="navigation-toggle-button" />
        <nuxt-link to="/home/all">
            <v-img
                :width="$vuetify.breakpoint.xs ? 35 : 50"
                :src="headerLogo"
            >
            </v-img>
        </nuxt-link>
        <v-toolbar-title class="ml-3 hidden-mobile-and-down">bestpra</v-toolbar-title>

        <v-spacer />

        <div>
            <v-menu
                app
                offset-x
                offset-y
                max-width="280"
                class="z-500"
            >
                <template
                    #activator="{ on }"
                >
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
                <v-list
                >
                <div v-if="notificationHeader.length === 0">
                    <v-list-item
                        class="pa-2"
                    >
                        <v-list-item-content
                            class="text-center"
                        >
                            まだ通知はありません
                        </v-list-item-content>
                    </v-list-item>
                </div>
                <div v-else>
                    <div
                        v-for="(notification, index) in notificationHeader"
                        :key="index"
                    >
                        <NotificationMain
                            header-flg
                            :notification="notification"
                        />
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
import headerLogo from '~/assets/img/header/header-logo.png'
import AvatarSwitch from '~/components/Molecules/AvatarSwitch.vue'
import NotificationMain from '~/components/Molecules/NotificationMain.vue'

export default {
    components: {
        AvatarSwitch,
        NotificationMain
    },
    data() {
        return {
            headerLogo,
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