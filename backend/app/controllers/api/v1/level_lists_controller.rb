class Api::V1::LevelListsController < ApplicationController
    # before_action :authenticate_user

    def index
        @level_lists = LevelList.where(delete_flg: false).as_json(only: [:id, :name])
        render json: @level_lists
    end

end