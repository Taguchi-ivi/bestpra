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
        # @user = User.find(params[:id])
        # if @user.update(user_params)
        # if @user.update_attributes(params[:user])
        #     # flash[:success] = "Object was successfully updated"
        #     # redirect_to @user
        # else
        #     # flash[:error] = "Something went wrong"
        #     # render 'edit'
        # end
        # render json: 'Usersupdate'
        if current_user.update(user_params)
            render status: :ok
        else
            render status: :bad_request
        end
    end

    # def destroy

    #     return if current_user.id != @user.id
    #     # user = User.find(params[:id])
    #     # if user.destroy!
    #     #     # flash[:success] = 'Object was successfully deleted.'
    #     #     # redirect_to users_url
    #     # else
    #     #     # flash[:error] = 'Something went wrong'
    #     #     # redirect_to users_url
    #     # end

    #     # user = User.find(params[:id])
    #     # user.destroy!
    #     render json: 'Usersdestroy'
    # end

    private
        def user_params
            # params.require(:user).permit(:nickname, :email, :avatar, :introduction, :birthday , :basecok_id )
            params.require(:user).permit(:id, :nickname, :email, :password, :avatar, :introduction, :birthday , :basecolor_id, :activated, :admin)
        end

        def set_user
            @user = User.find(params[:id])
        end


end