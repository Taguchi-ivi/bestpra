<template>
    <div>
        <v-list-item
            three-line
            :class="colorSwitch(notification.checked)"
        >
            <v-list-item-avatar>
                <AvatarSwitch
                    :id="notification.visitor_id"
                    :avatar-url="notification.visitor.avatar.url"
                />
            </v-list-item-avatar>
            <v-list-item-content>
                <div v-if="notification.action === 'like' || notification.action === 'comment'">
                    <v-list-item-title>
                        <span v-if="notification.action === 'like'">いいね</span>
                        <span v-if="notification.action === 'comment'">コメント</span>
                    </v-list-item-title>
                    <v-list-item-subtitle
                        class="mt-3"
                    >
                        <nuxt-link
                            :to="`/users/${notification.visitor_id}/all`"
                            class="active-link"
                            >
                            {{ $my.shortVersion(notification.visitor.nickname, 8) }}
                        </nuxt-link>
                        さんが
                        <nuxt-link
                            :to="`/articles/${notification.article.id}`"
                            class="active-link"
                        >
                            あなたの記事
                        </nuxt-link>
                        に
                        <span v-if="notification.action === 'like'">いいね</span>
                        <span v-if="notification.action === 'comment'">コメント</span>
                        しました
                    </v-list-item-subtitle>
                    <div
                        v-if="notification.action === 'comment'"
                        class="mt-2 text--secondary"
                        style="font-size: 10px;"
                    >
                        {{ $my.shortVersion(notification.comment.content, 20) }}
                    </div>
                </div>
                <div v-else-if="notification.action === 'follow'">
                    <v-list-item-title>フォロー</v-list-item-title>
                    <v-list-item-subtitle
                        class="mt-3"
                    >
                        <nuxt-link
                            :to="`/users/${notification.visitor_id}/all`"
                            class="active-link"
                        >
                            {{ $my.shortVersion(notification.visitor.nickname, 8) }}
                        </nuxt-link>
                        さんがあなたをフォローしました
                    </v-list-item-subtitle>
                </div>
                <div class="text-right text-caption">
                    {{ $my.dataFormat(notification.created_at) }}
                </div>
            </v-list-item-content>
        </v-list-item>
        <v-divider
            v-if="dividerFlg"
        />
    </div>
</template>

<script>
import { mapGetters } from 'vuex'
import AvatarSwitch from '~/components/Molecules/AvatarSwitch.vue'

export default {
    components: {
        AvatarSwitch,
    },
    props: {
        notification: {
            type: Object,
            default: () => {},
        },
        dividerFlg: {
            type: Boolean,
            default: true,
        },
        headerFlg: {
            type: Boolean,
            default: false,
        }
    },
    computed: {
        ...mapGetters({
            notificationHeader: 'modules/notification/getNotificationHeader'
        }),
    },
    // beforeDestroy () {
    //     // Vueインスタンスが破棄される直前にVuexのtoast.msgを削除する(無期限toastに対応)
    //     this.resetToast()
    // },
    methods: {
        colorSwitch(checked)  {
            return checked ? 'not-active' : ''
        }
    }
}

</script>

<style lang="scss" scoped>
.active-link {
    color: #5EB9B0;
    font-weight: bold;
}

.not-active {
    background-color: #F5F5F5;
}
</style>