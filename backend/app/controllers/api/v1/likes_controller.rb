class Api::V1::LikesController < ApplicationController
    # before_action :authenticate_user
    before_action :authenticate_active_user

    def create
        article = Article.find(params[:article_id])
        article.likes.create!(user_id: current_user.id)
        article.create_notification_like!(current_user)
        render json: { status: 'SUCCESS', message: 'いいね完了!!' }
    end

    def destroy
        article = Article.find(params[:article_id])
        like = article.likes.find_by!(user_id: current_user.id)
        like.destroy!
        article.delete_notification_like!(current_user)
        render json: { status: 'SUCCESS', message: 'いいね解除完了!!' }
    end

end