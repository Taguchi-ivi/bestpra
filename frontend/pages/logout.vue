<script>
export default {
    // ページをレンダリングする前に実行
    middleware ({ redirect }) {
        return redirect('/about')
    }
}
</script>