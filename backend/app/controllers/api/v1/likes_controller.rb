class Api::V1::LikesController < ApplicationController
    before_action :authenticate_user

    def index

    end

    def create
        article = Article.find(params[:article_id])
        article.likes.create!(user_id: current_user.id)
        # if like.save
        #     render json: like.as_json(only: [:id, :user_id, :article_id, :created_at])
        # else
        #     render json: { errors: like.errors }, status: :unprocessable_entity
        # end
    end

    def destroy
        article = Article.find(params[:article_id])
        like = article.likes.find_by!(user_id: current_user.id)
        like.destroy!
        # if like.destroy
        #     render json: like.as_json(only: [:id, :user_id, :article_id, :created_at])
        # else
        #     render json: { errors: like.errors }, status: :unprocessable_entity
        # end
    end

end