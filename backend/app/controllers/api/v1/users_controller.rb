class Api::V1::UsersController < ApplicationController
    # skip_before_action :authenticate
    # createメソッドのみログイン済みかどうかの判定をスキップする
    before_action :authenticate_user
    before_action :set_user, only: [:show, :update, :destroy]

    # current_userで値を取得できる

    def index
        users = User.all
        #avatar必要
        # as_json => ハッシュの形でJSONデータを返す {"id" => 1, "nickname" => "test", ...}
        # render json: users.as_json(only: [:id, :nickname, :email, :created_at])
        # render json: current_user.as_json(only: [:id, :nickname, :email, :created_at])
        render json: users
    end

    def show
        # current_userか判定
        flg = current_user.id == @user.id ? true : false
        # render json: 'Usersshow'
        render json: @user.as_json(only: [:id, :nickname, :avatar, :introduction]).merge(current_user: flg).with_indifferent_access
    end


    def edit
        # @user = User.find(params[:id])
        # render json: 'Usersedit'
        # render json: @user.as_json(only: [:id, :nickname, :avatar, :email, :introduction, :birthday])
        render json: current_user.as_json(only: [:id, :nickname, :avatar, :email, :introduction, :birthday])
    end

    def update
        if current_user.update(user_params)
            render status: :ok
        else
            render status: :bad_request
        end
    end

    # TODO S3にアップロードする
    def update_avatar
        # @user = current_user
        if current_user.update!(avatar: params[:user][:avatar])
            render json: current_user
        else
            render status: :bad_request
        end
    end


    private
        def user_params
            # params.require(:user).permit(:id, :nickname, :introduction, :birthday , :basecolor_id, :activated, :admin)
            params.require(:user).permit(:id, :nickname, :introduction, :birthday)
        end

        def set_user
            @user = User.find(params[:id])
        end


end