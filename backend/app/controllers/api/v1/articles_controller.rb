class Api::V1::ArticlesController < ApplicationController
    before_action :authenticate_user

    before_action :set_article, only: [:edit, :update]

    def index
        # users = User.all
        # render json: users
        articles = Article.joins(:level_list).select("articles.*,level_lists.name as level_name").all
        render json: articles.as_json(include: {user: { only: [:id, :nickname, :avatar]}})
    end

    def show
        # article = Article.find(params[:id])
        # render json: @article.as_json()
        # render json: @article.as_json(include: :user {
        #                                         only: [:id, :nickname, :avatar] })
        # render json: @article.as_json(include: {user: { only: [:id, :nickname, :avatar]}})
        # comment時に下記は役に立つかも
        # render json: @article.as_json(include: { user: {
        #                                             include: { level_list: {
        #                                                     only: :name }},
        #                                             only: [:id, :nickname, :avatar]}})
        # article_join_data = article.joins(:level_list)
        # render json: article_join_data
        # render json: @article.joins(:level_list).as_json(include: { user: {
        #                                                         include: { level_list: {
        #                                                                 only: :name }},
        #                                                         only: [:id, :nickname, :avatar]}})
        article = Article.joins(:level_list).select("articles.*,level_lists.name as level_name").find(params[:id])
        render json: article.as_json(include: {user: { only: [:id, :nickname, :avatar]}})
    end

    # aboutページ用の3件のarticleを取得
    # TODO いいねの数が多い3件を取得する
    def about
        # articles = Article.where(about: true).limit(3) order(like)
        # render json: articles
    end

    def create
        # @article = current_user.articles.build(article_params)
        @article = current_user.articles.build(article_params)
        if @article.save!
            render json: @article
        else
            render json: @article.errors.full_messages
        end
    end

    def edit
        render json: @article.as_json()
    end

    def update
        return if current_user_for_article
        if @article.update!(article_params)
            render json: @article
        else
            render json: @article.errors.full_messages
        end
    end

    def destroy
        return current_user_for_article
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

        def set_article
            @article = current_user.articles.find(params[:id])
        end

        def current_user_for_article
            current_user.id != params[:id]
        end

end