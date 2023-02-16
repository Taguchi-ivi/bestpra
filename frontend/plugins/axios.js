export default ({ $axios }) => {
    // リクエストログ
    $axios.onRequest((config) => {

        // axiosのグローバル設定
        // headerにX-Requested-withを付与
        config.headers.common['X-Requested-With'] = 'XMLHttpRequest'
        console.log(config)
    })
    // レスポンスログ
    $axios.onResponse((config) => {
        console.log(config)
    })
    // エラーログ
    $axios.onError((e) => {
        console.log(e.response)
    })
}