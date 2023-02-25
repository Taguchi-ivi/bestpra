class Api::V1::LevelListsController < ApplicationController
    before_action :authenticate_user

    def index
        @level_lissts = LevelList.all
        render json @level_lissts
    end

end