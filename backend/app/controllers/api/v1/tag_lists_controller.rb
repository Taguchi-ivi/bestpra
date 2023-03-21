class Api::V1::TagListsController < ApplicationController
    # before_action :authenticate_user
    before_action :authenticate_active_user

    def index
        # nameでソート
        tag_list = TagList.left_joins(:tag_maps)
                            .select('tag_lists.id, tag_lists.name, count(tag_maps.tag_list_id) as tag_count')
                            .group('id')
                            .where(delete_flg: false)
                            .order('tag_count desc')
        render json: tag_list
    end

    # tag_idに紐づくarticleデータを全件取得
    def article_tag
        tag_id = params[:tag_list_id]
        # return render status: :bad_request unless TagList.exists?(id: tag_id, delete_flg: false)
        return render json: :bad_request unless TagList.exists?(id: tag_id, delete_flg: false)

        render json: TagList.find(tag_id).articles
                                            .includes(:user, :level_list, :tag_list, :comments)
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
        return render json: '存在しません' unless TagList.exists?(id: params[:id])

        tag_list = TagList.find(params[:id])
        if tag_list.update(tag_list_params)
            @tag_list = TagList.where(delete_flg: false).order(:name).as_json(only: [:id, :name])
            render json: @tag_list
        else
            render json: { errors: tag_list.errors }, status: :unprocessable_entity
        end
    end

    def create
        return render json: '権限がありません' if admin

        tag_list = TagList.new(tag_list_params)
        return render json: '既に存在してます' if TagList.exists?(name: tag_list_params[:name])

        if tag_list.save
            @tag_lists = TagList.where(delete_flg: false).as_json(only: [:id, :name])
            render json: @tag_lists
        else
            render json: { errors: tag_list.errors }, status: :unprocessable_entity
        end
    end

    private

        def tag_list_params
            params.require(:tag_list).permit(:name, :delete_flg)
        end

        def admin
            current_user.admin?
        end

end