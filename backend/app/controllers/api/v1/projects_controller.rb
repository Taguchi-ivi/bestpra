class Api::V1::ProjectsController < ApplicationController
    # メール認証する場合はactive_userメソッドを使用する
    # before_action :authenticate_active_user
    # authenticate検証用
    before_action :authenticate_user

    def index
        projects = []
        date = Date.new(2021,4,1)
        10.times do |n|
            id = n + 1
            nickname = "#{current_user.nickname} project #{id.to_s.rjust(2, "0")}"
            updated_at = date + (id * 6).hours
            projects << { id: id, nickname: nickname, updatedAt: updated_at }
        end
        # 本来はcurrent_user.projects
        render json: projects
    end
end