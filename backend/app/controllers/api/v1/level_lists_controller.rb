class Api::V1::LevelListsController < ApplicationController
    # before_action :authenticate_user
    before_action :authenticate_active_user

    def index
        @level_lists = LevelList.where(delete_flg: false).as_json(only: [:id, :name])
        render json: @level_lists
    end

    # level_idに紐づくarticleデータを全件取得
    def article_level
        level_id = params[:level_list_id]
        # return render status: :bad_request unless LevelList.exists?(id: level_id, delete_flg: false)
        return render json: :bad_request unless LevelList.exists?(id: level_id, delete_flg: false)

        render json: Article.includes(:user, :level_list, :tag_list, :comments)
                                .where(level_list_id: level_id)
                                .order(created_at: :desc)
                                .as_json(include: [
                                            {user: { only: [:id, :nickname, :avatar]}},
                                            {level_list: { only: [:id, :name]}},
                                            {tag_list: { only: [:id, :name]}},
                                            {comments: { only: [:id]}}
                                        ])
    end

    def update
        return render json: '権限がありません' if admin
        return render json: '存在しません' unless tag_list.exists?(name: params[:tag_list][:name])

        level_list = LevelList.find(params[:id])

        if tag_list.update(tag_list_params)
            @tag_list = TagList.where(delete_flg: false).order(:name).as_json(only: [:id, :name])
            render json: @tag_list
        else
            render json: { errors: tag_list.errors }, status: :unprocessable_entity
        end
    end

    def create

        return render json: '権限がありません' if admin

        level_list = LevelList.new(level_list_params)
        return render json: '存在してます' if LevelList.exists?(name: level_list_params[:name])

        if level_list.save
            @level_lists = LevelList.where(delete_flg: false).as_json(only: [:id, :name])
            render json: @level_lists
        else
            render json: { errors: level_list.errors }, status: :unprocessable_entity
        end
    end

    private

        def level_list_params
            params.require(:level_list).permit(:name, :delete_flg)
        end

        def admin
            current_user.admin?
        end

end