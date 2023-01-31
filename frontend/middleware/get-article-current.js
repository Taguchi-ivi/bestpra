// article検索
// home.vueに記載 middleware: 'get-article-current'
export default async ({ store, params }) => {
    return await store.dispatch('getCurrentArticle', params)
}
