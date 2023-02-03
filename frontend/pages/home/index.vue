<template>
    <div>
        <h1>dashboard</h1>
        <!-- <v-btn
            class="white--text"
            color="blue"
            @click="testBtn"
        >
            テスト
        </v-btn>
        <p>
            {{ users }}
        </p> -->
    </div>
</template>

<script>
export default {
    // middleware: 'get-article-current',
    layout: 'home',
    middleware: ['before-login-user'],
    data() {
        return {
            users: {}
        }
    },
    methods: {
        testBtn() {
            // const user = {
            //     nickname: this.params.user.name,
            //     email: this.params.user.email,
            //     uid: 'aaaaaaaaaa'
            // }
            // this.$axios.post('/api/v1/users', { user })
            //     .then(response => {
            //             console.log(response)
            //         })
            // this.$axios.get('/api/v1/users')
            //     .then(response => {
            //         this.users = response.data
            //     })
        },
    },
}
</script>