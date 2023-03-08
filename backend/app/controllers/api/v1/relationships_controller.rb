class Api::V1::RelationshipsController < ApplicationController
    before_action :authenticate_user

    def create
        user = User.find(params[:user_id])
        current_user.follow(user)
    end

    def unfollow
        user = User.find(params[:user_id])
        current_user.unfollow(user)
    end


    # フォローしているユーザー一覧を取得する
    def following
        return render json: :bad_request unless User.exists?(id: params[:user_id])
        follow_ids = User.find(params[:user_id]).following.pluck(:id)
        render json: User.includes(:passive_relationships)
                            .where(id: follow_ids)
                            .order("relationships.created_at DESC")
                            .as_json(only: [:id, :nickname, :avatar,:introduction])
    end

    # フォロワー一覧を取得する
    def followers
        return render json: :bad_request unless User.exists?(id: params[:user_id])
        follower_ids = User.find(params[:user_id]).followers.pluck(:id)
        # render json: User.where(id: follower_ids).as_json(only: [:id, :nickname, :avatar,:introduction])
        render json: User.includes(:active_relationships)
                            .where(id: follower_ids)
                            .order("relationships.created_at DESC")
                            .as_json(only: [:id, :nickname, :avatar,:introduction])

    end


end