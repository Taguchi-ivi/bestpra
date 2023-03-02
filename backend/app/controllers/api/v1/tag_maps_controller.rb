class Api::V1::TagMapsController < ApplicationController
    before_action :authenticate_user

    def update
        if tag_map.exisxt?(article_id: params[:article_id], tag_list_id: params[:tag_list_id])
    end

    def create

        level_list = LevelList.new(level_list_params)
        if level_list.save
            render json: level_list
        else
            render json: { errors: level_list.errors }, status: :unprocessable_entity
        end
    end

    private

        def level_list_params
            params.require(:level_list).permit(:name)
        end

        def tag_map_params
            params.require(:tag_map).permit(:article_id, :tag_list_id)
        end

end