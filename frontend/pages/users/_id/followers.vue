<template>
    <div>
        <MainTitle
            title="フォロワー"
        />
        <CardUser
            :users="followersUser"
        />
    </div>
</template>

<script>
import { mapGetters } from 'vuex'
import MainTitle from '~/components/Atom/App/AppMainTitle.vue'
import CardUser from '~/components/Organisms/Card/CardUser.vue'

export default {
    name: 'UsersFollowers',
    components: {
        MainTitle,
        CardUser,
    },
    async asyncData({ $axios, params, store }) {
        const res = await $axios.$get(`/api/v1/users/${params.id}/relationships/followers`)
        if(res === 'bad_request') {
            store.dispatch('modules/toast/getToast', {
                        status: true,
                        msg: '存在しないユーザーです',
                        color: 'error'
                    })
            return {
                error: true
            }
        }
        store.dispatch('modules/follow/getOtherFollower', res)
        return {
            error: false,
            // followersUser: res
        }
    },
    computed: {
        ...mapGetters({
            followersUser: 'modules/follow/getOtherFollower',
        }),
    },
}
</script>