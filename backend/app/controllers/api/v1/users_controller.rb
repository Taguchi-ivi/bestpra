class Api::V1::UsersController < ApplicationController
    # before_action :authenticate_user
    before_action :authenticate_active_user
    before_action :set_user, only: [:update, :destroy]

    def index
        users = User.all
        render json: users
    end

    def show
        # return render status: :bad_request unless User.exists?(id: params[:id])
        return render json: :bad_request unless User.exists?(id: params[:id])
        user_data =  User.find(params[:id]).as_json(only: [:id, :nickname, :avatar, :introduction])
        article_count = Article.where(user_id: params[:id]).count
        following_count = User.find(params[:id]).following.count
        followers_count = User.find(params[:id]).followers.count
        render json: user_data.merge({articles: article_count, following: following_count, followers: followers_count})
                                .with_indifferent_access
    end

    # 対象のユーザの執筆した記事を取得
    def written_articles
        # return render status: :bad_request unless User.exists?(id: params[:user_id])
        return render json: :bad_request unless User.exists?(id: params[:user_id])
        user = User.find(params[:user_id])
        render json:  user.articles.includes(:likes, :level_list, :tag_list, comments: :user)
                                        .order(id: :desc)
                                        .as_json(include: [
                                                {user: { only: [:id, :nickname, :avatar]}},
                                                {likes: { only: [:user_id]}},
                                                {level_list: { only: [:id, :name]}},
                                                {tag_list: { only: [:id, :name]}},
                                                {comments: { include: [
                                                    user: { only: [:id] },]}},
                                            ])
    end

    # 対象のユーザのいいね一覧を取得
    def likes
        # return render status: :bad_request unless User.exists?(id: params[:user_id])
        return render json: :bad_request unless User.exists?(id: params[:user_id])
        user = User.find(params[:user_id])
        render json: user.likes.includes(article: [:user, :level_list, :tag_list, :comments])
                        .order(article_id: :desc)
                        .as_json(include:
                                { article:
                                    { include: [
                                        {user: { only: [:id, :nickname, :avatar]}},
                                        {level_list: { only: [:id, :name]}},
                                        {tag_list: { only: [:id, :name]}},
                                        {comments: { only: [:user_id]}}]
                                    }})
    end

    # 自身のフォローしているIDを取得する
    def current_following
        render json: current_user.following.pluck(:id)
    end

    def search
        keyword = params[:keyword]
        return render json: [] if keyword.blank?
        users = User.where('nickname LIKE ? OR introduction LIKE ?', "%#{keyword}%", "%#{keyword}%")
                        .as_json(only: [:id, :nickname, :avatar, :introduction])
        render json: users
    end

    def edit
        render json: current_user.as_json(only: [:id, :nickname, :avatar, :email, :introduction, :birthday, :guest_flg])
    end

    def update
        if current_user.update(user_params)
            render status: :ok
        else
            # render status: :bad_request
            render json: { errors: current_user.errors }, status: :unprocessable_entity
        end
    end

    def update_avatar
        if current_user.update!(avatar: params[:user][:avatar])
            render json: current_user
        else
            render json: current_user.errors.full_messages
        end
    end


    private
        def user_params
            # params.require(:user).permit(:id, :nickname, :introduction, :birthday , :basecolor_id, :activated, :admin)
            params.require(:user).permit(:nickname, :introduction, :birthday)
        end

        def set_user
            @user = User.find(params[:id])
        end


end