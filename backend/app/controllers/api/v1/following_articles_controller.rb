class Api::V1::FollowingArticlesController < ApplicationController
    before_action :authenticate_user

    def index
        # フォローしているユーザーの記事一覧を取得
        # render json: User.find(24).following
        # render json: current_user.following
        #                             .includes(articles: [:likes, :level_list, :tag_list, :comments])
        #                             .order("articles.id DESC")
        #                             .as_json( only: [:id],
        #                                     include:
        #                                     { articles:
        #                                         { include: [
        #                                             {user: { only: [:id, :nickname, :avatar]}},
        #                                             {likes: { only: [:user_id]}},
        #                                             {level_list: { only: [:id, :name]}},
        #                                             {tag_list: { only: [:name]}},
        #                                             {comments: { only: [:user_id]}}]
        #                                     }})
        # following_id = User.find(24).following.pluck(:id)
        following_id = current_user.following.pluck(:id)
        articles = Article.includes(:user, :likes, :level_list, :tag_list, :comments)
                            .where(user_id: following_id)
                            .order(id: :desc)
                            .as_json(include: [
                                {user: { only: [:id, :nickname, :avatar]}},
                                {likes: { only: [:user_id]}},
                                {level_list: { only: [:id, :name]}},
                                {tag_list: { only: [:name]}},
                                {comments: { only: [:id]}},
                            ])
        render json: articles
    end

end