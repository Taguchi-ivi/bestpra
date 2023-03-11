class Api::V1::NotificationsController < ApplicationController
    before_action :authenticate_user

    def index
        # notifications = User.first.passive_notifications
        notifications = current_user.passive_notifications
        render json: notifications.includes(:visitor, :article, :comment, :level_list)
                                        .as_json(include: [
                                            {visitor: { only: [:id, :nickname, :avatar]}},
                                            {article: { only: [:id, :title]}},
                                            {comment: { only: [:id, :content]}}
                                        ]), status: :ok
        # notifications = Notification.includes(:visitor).all
        # render json: notifications.to_json(include: { visited: { only: [:id, :name] } })
    end

    # 5件取得
    def read
        # notifications = User.first.passive_notifications.limit(5)
        notifications = current_user.passive_notifications.limit(5)
        render json: notifications.includes(:visitor, :article, :comment, :level_list)
                                        .as_json(include: [
                                            {visitor: { only: [:id, :nickname, :avatar]}},
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