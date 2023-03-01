class Api::V1::ArticlesController < ApplicationController
    before_action :authenticate_user

    # before_action :set_article, only: [:edit, :update]

    def index

        render json: Article.all.as_json(include: [
                                    {user: { only: [:id, :nickname, :avatar]}},
                                    {level_list: { only: [:id, :name]}},
                                    {tag_list: { only: [:name]}}
                                ])
    end

    def show

        # オーバーライズしたレコードを取得 ※article modelも修正が必要
        # render json: Article.find(params[:id]).as_json
        render json: Article.find(params[:id]).as_json(include: [
                                                    {user: { only: [:id, :nickname, :avatar]}},
                                                    {level_list: { only: [:id, :name]}},
                                                    {tag_list: { only: [:name]}}
                                                ])

    end

    # aboutページ用の3件のarticleを取得
    # TODO いいねの数が多い3件く、最新のデータを取得する
    def about
        # articles = Article.where(about: true).limit(3).order(like)
    end

    # paramsの値が存在することを確認
    # 記事の当事者か確認
    def edit

        return render json: :bad_request unless Article.exists?(id: params[:id])
        @article = Article.find(params[:id])
        return render json: :bad_request unless @article.user_id == current_user.id

        render json:  @article.as_json(), status: :ok
    end

    def update
        return if current_user_for_article
        @article = current_user.articles.find(params[:id])
        if @article.update!(article_params)

            # タグ情報も作成する
            tag_list = params[:article][:tags].split('[sp|it]]')
            @article.delete_tag_map
            @article.save_tags(tag_list) unless tag_list.empty?
            render json: @article
        else
            render json: @article.errors.full_messages
        end
    end

    def create
        # @article = current_user.articles.build(article_params)
        # tag情報も作成する
        @article = current_user.articles.build(article_params)
        if @article.save!

            # タグ情報も作成する
            tag_list = params[:article][:tags].split('[sp|it]]')
            @article.save_tags(tag_list) unless tag_list.empty?

            render json: @article
        else
            render json: @article.errors.full_messages
        end
    end

    def destroy
        return if current_user_for_article
        article = current_user.articles.find(params[:id])
        if article.destroy!
            render status: :ok
        else
            render article.errors.full_messages
        end
    end

    private

        def article_params
            # params.require(:user).permit(:id, :nickname, :introduction, :birthday , :basecolor_id, :activated, :admin)
            params.require(:article).permit(:title, :content, :image, :level_list_id)
        end

        # def set_article
        #     # @article = Article.find(params[:id])
        #     @article = current_user.articles.find(params[:id])
        # end

        def current_user_for_article
            current_user.id != Article.find(params[:id]).user_id
        end

        def delete_tag_map
            return unless TagMap.exists?(article_id: self.id)
            TagMap.where(article_id: self.id).destroy_all

            # 必要無くなったタグは削除する
            self.tags.each do |tag|
                if TagMap.where(id: tag.tag_list_id).count == 0
                    TagList.where(tag_id: tag.id).destroy_all
                end
            end
        end

        def save_tags(tag_list)
            tag_list.each do |tag_name|
                next if tag_name.empty?
                tag = Tag.find_or_create_by(name: tag_name)
                self.tags << tag
            end
        end

end