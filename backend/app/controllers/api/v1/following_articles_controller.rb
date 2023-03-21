class Api::V1::FollowingArticlesController < ApplicationController
    # before_action :authenticate_user
    before_action :authenticate_active_user

    # フォローしているユーザーの記事一覧を取得
    def index
        following_id = current_user.following.pluck(:id)
        articles = Article.includes(:user, :likes, :level_list, :tag_list, :comments)
                            .where(user_id: following_id)
                            .order(id: :desc)
                            .as_json(include: [
                                {user: { only: [:id, :nickname, :avatar]}},
                                {likes: { only: [:user_id]}},
                                {level_list: { only: [:id, :name]}},
                                {tag_list: { only: [:id, :name]}},
                                {comments: { only: [:id]}},
                            ])
        render json: articles
    end

end