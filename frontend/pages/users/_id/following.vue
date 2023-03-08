<template>
    <div>
        <MainTitle
            title="フォロー"
        />
        <CardUser
            :users="followingUser"
        />
    </div>
</template>

<script>
import MainTitle from '~/components/Atom/App/AppMainTitle.vue'
import CardUser from '~/components/Organisms/Card/CardUser.vue'

export default {
    components: {
        MainTitle,
        CardUser,
    },
    async asyncData({ $axios, params, store }) {
        const res = await $axios.$get(`/api/v1/users/${params.id}/relationships/following`)
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
        return {
            error: false,
            followingUser: res
        }
    }
}
</script>