class Api::V1::FollowingArticlesController < ApplicationController
    before_action :authenticate_user

    def index
        # フォローしているユーザーの記事一覧を取得
        # render json: current_user.following
        # TODO res => articles => item => item.articles
        render json: User.find(24).following
                                    .includes(articles: [:likes, :level_list, :tag_list, :comments])
                                    .order("articles.id DESC")
                                    .as_json( only: [:id],
                                            include:
                                            { articles:
                                                { include: [
                                                    {user: { only: [:id, :nickname, :avatar]}},
                                                    {likes: { only: [:user_id]}},
                                                    {level_list: { only: [:id, :name]}},
                                                    {tag_list: { only: [:name]}},
                                                    {comments: { only: [:user_id]}}]
                                            }})
    end

end