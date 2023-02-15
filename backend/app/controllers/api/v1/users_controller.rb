class Api::V1::UsersController < ApplicationController
    # skip_before_action :authenticate
    before_action :set_user, only: [:show, :edit, :update]

    def index
        users = User.all
        #avatar必要
        # as_json => ハッシュの形でJSONデータを返す {"id" => 1, "nickname" => "test", ...}
        render json: users.as_json(only: [:id, :nickname, :email, :created_at])
    end

    def show
        # @current_user = User.find(params[:id])
        render json: 'Usersshow'
    end

    def create
        @user = User.new(user_params)
        if @user.save
        #   flash[:success] = "Object successfully created"
        #   redirect_to @user
            render json: @user
        else
        #   flash[:error] = "Something went wrong"
        #   render 'new'
            # render json: status: 'error'
        end
        # render json: 'Userscreate'
    end

    def edit
        # @user = User.find(params[:id])
        render json: 'Usersedit'
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
        render json: 'Usersupdate'
    end

    def destroy
        # user = User.find(params[:id])
        # if user.destroy!
        #     # flash[:success] = 'Object was successfully deleted.'
        #     # redirect_to users_url
        # else
        #     # flash[:error] = 'Something went wrong'
        #     # redirect_to users_url
        # end

        # user = User.find(params[:id])
        # user.destroy!
        render json: 'Usersdestroy'
    end

    private
        def user_params
            params.require(:user).permit(:nickname, :email, :uid, :avatar, :introduction, :birthday , :basecok_id)
        end

        def set_user
            @user = User.find(params[:id])
        end


end