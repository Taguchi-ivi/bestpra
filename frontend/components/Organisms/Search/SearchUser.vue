<template>
    <div>
        <v-card
            max-width="80%"
            class="mx-auto pa-3"
            color="transparent"
            flat
        >
            <v-text-field
                v-model="searchUser"
                label="ユーザー検索"
                solo
                prepend-inner-icon="mdi-magnify"
                class="mx-auto mt-8"
            >
            </v-text-field>
            <div v-if="loading">
                <TheLoading />
            </div>
            <div v-else>
                <div class="text-right py-4">
                    <span>検索結果: {{ users.length }}件</span>
                </div>
                <CardUser
                    :users="users"
                />
            </div>
        </v-card>
    </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import _ from 'lodash'
import CardUser from '~/components/Organisms/Card/CardUser.vue'
import TheLoading from '~/components/Organisms/Application/TheLoading.vue'

export default {
    components: {
        CardUser,
        TheLoading
    },
    data() {
        return {
            loading: false,
            searchUser: '',
        }
    },
    computed: {
        ...mapGetters({
            users: 'modules/user/getSearchUsers',
        })
    },
    watch: {
        searchUser() {
            this.dispatchResetUsers()
            if(this.searchUser.length > 0) {
                this.delayFunc()
            }
        }
    },
    // mounted() {
    //     this.dispatchResetUsers()
    // },
    created() {
        this.delayFunc = _.debounce(this.search, 500)
    },
    methods: {
        ...mapActions({
            dispatchUsers: 'modules/user/getSearchUsers',
            dispatchResetUsers: 'modules/user/getResetSearchUsers',
        }),
        async search() {
            this.loading = true
            await this.$axios.get('/api/v1/users/search', {
                params: {
                    keyword: this.searchUser
                }
            })
                .then(res => {
                    res.data.length > 0 ? this.dispatchUsers(res.data) : this.dispatchResetUsers()
                })
                .catch(err => {
                    console.log(err)
                })
            this.loading = false
        }
    },
}
</script>