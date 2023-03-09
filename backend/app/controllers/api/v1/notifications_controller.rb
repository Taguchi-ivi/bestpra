class Api::V1::LikesController < ApplicationController
    before_action :authenticate_user

    def index
        notifications = current_user.passive_notifications
        render json: notifications.as_json(include: [
                                                {user: { only: [:id, :nickname, :avatar]}},
                                                {article: { only: [:id, :title]}},
                                                {comment: { only: [:id, :content]}}
                                            ]), status: :ok
    end

    # 5件取得
    def read
        notifications = current_user.passive_notifications
        render json: notifications.as_json(include: [
                                                {user: { only: [:id, :nickname, :avatar]}},
                                                {article: { only: [:id, :title]}},
                                                {comment: { only: [:id, :content]}}
                                            ]), status: :ok
    end

    # チェックされたらそのidのcheckedをtrueにする
    def update
        notification = current_user.passive_notifications.find(params[:id])
        if notification.update(checked: true)
            render status: :ok
        else
            render json: notification.errors.full_messages, status: :unprocessable_entity
        end
    end

    # 全てのcheckedをtrueにする
    def all_update
        notifications = current_user.passive_notifications
        notifications.each do |notification|
            notification.update(checked: true)
        end
    end

end