class Api::V1::MstListsController < ApplicationController
    before_action :authenticate_user

    # マスタ情報を取得取得する
    # TODO タグ情報を追加すること
    def index
        # @tags = Tag.where(delete_flg: false).as_json(only: [:id, :name])
        # render json: {levels: @level_lissts, tags: @tags}
        @level_lists = LevelList.where(delete_flg: false).as_json(only: [:id, :name])
        render json: @level_lists
    end

end