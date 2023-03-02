class Api::V1::LevelListsController < ApplicationController
    before_action :authenticate_user

    def index
        @level_lists = LevelList.where(delete_flg: false).as_json(only: [:id, :name])
        render json: @level_lists
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