<script>
export default {
    // ページをレンダリングする前に実行
    async middleware ({ $auth, redirect }) {
        await $auth.logout()
        return redirect('/about')
    }
}
</script>