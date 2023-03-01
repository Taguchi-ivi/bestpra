class Api::V1::TagListsController < ApplicationController
    before_action :authenticate_user

    def index
        # @tags = Tag.where(delete_flg: false).as_json(only: [:id, :name])
        # render json: {levels: @level_lissts, tags: @tags}
        tag_list = TagList.where(delete_flg: false).as_json(only: [:id, :name])
        render json: tag_list
    end

end