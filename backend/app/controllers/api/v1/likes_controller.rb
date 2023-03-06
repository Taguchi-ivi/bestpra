class Api::V1::LikesController < ApplicationController
    before_action :authenticate_user

    def create
        article = Article.find(params[:article_id])
        article.likes.create!(user_id: current_user.id)
    end

    def destroy
        article = Article.find(params[:article_id])
        like = article.likes.find_by!(user_id: current_user.id)
        like.destroy!
    end

end