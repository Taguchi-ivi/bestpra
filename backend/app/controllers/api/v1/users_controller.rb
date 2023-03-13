class Api::V1::UsersController < ApplicationController
    # skip_before_action :authenticate
    # createメソッドのみログイン済みかどうかの判定をスキップする
    before_action :authenticate_user
    before_action :set_user, only: [:update, :destroy]

    # current_userで値を取得できる

    def index
        # TODO 全件取得する際に、項目を絞ること
        users = User.all
        #avatar必要
        # as_json => ハッシュの形でJSONデータを返す {"id" => 1, "nickname" => "test", ...}
        # render json: users.as_json(only: [:id, :nickname, :email, :created_at])
        # render json: current_user.as_json(only: [:id, :nickname, :email, :created_at])
        render json: users
    end

    def show
        # current_userか判定
        # flg = current_user.id == @user.id ? true : false
        # render json: 'Usersshow'
        # render json: @user.as_json(only: [:id, :nickname, :avatar, :introduction])
        # render json: {user: user_data, articles: articles}
        # render json: User.find(params[:id]).as_json(only: [:id, :nickname, :avatar, :introduction])
        # render json: {user: user_data, articles: article_count, following: following_count, followers: followers_count}
        return render json: :bad_request unless User.exists?(id: params[:id])
        user_data =  User.find(params[:id]).as_json(only: [:id, :nickname, :avatar, :introduction])
        article_count = Article.where(user_id: params[:id]).count
        following_count = User.find(params[:id]).following.count
        followers_count = User.find(params[:id]).followers.count
        render json: user_data.merge({articles: article_count, following: following_count, followers: followers_count})
                                .with_indifferent_access
    end

    def written_articles
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

    def likes
        # 対象のユーザのいいね一覧を取得
        return render json: :bad_request unless User.exists?(id: params[:user_id])
        user = User.find(params[:user_id])
        render json: user.likes.includes(article: [:user, :level_list, :tag_list, :comments])
                        .order(article_id: :desc)
                        .as_json(include:
                                { article:
                                    { include: [
                                        {user: { only: [:id, :nickname, :avatar]}},
                                        {level_list: { only: [:id, :name]}},
                                        {tag_list: { only: [:name]}},
                                        {comments: { only: [:user_id]}}]
                                    }})
    end

    # フォローしているIDを取得する
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
        # @user = User.find(params[:id])
        # render json: 'Usersedit'
        # render json: @user.as_json(only: [:id, :nickname, :avatar, :email, :introduction, :birthday])
        render json: current_user.as_json(only: [:id, :nickname, :avatar, :email, :introduction, :birthday])
    end

    def update
        if current_user.update(user_params)
            render status: :ok
        else
            render status: :bad_request
        end
    end

    # TODO S3にアップロードする
    def update_avatar
        # @user = current_user
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