// export default ({ $axios, $auth, isDev }) => {
export default ({ $axios, $auth }) => {
    // リクエストログ
    $axios.onRequest((config) => {

        // axiosのグローバル設定
        // headerにX-Requested-withを付与
        config.headers.common['X-Requested-With'] = 'XMLHttpRequest'

        // リクエスト時にtokenを送る(グローバル設定)
        if($auth.token) {
            config.headers.common.Authorization = `Bearer ${$auth.token}`
        }

        // 開発環境用コンテキスト
        // if(isDev){
        //     // console.log(config)
        // }
    })
    // レスポンスログ
    $axios.onResponse((config) => {
        // if(isDev) {
        //     // console.log(config)
        // }
    })
    // エラーログ
    $axios.onError((e) => {
        console.log(e.response)
    })
}