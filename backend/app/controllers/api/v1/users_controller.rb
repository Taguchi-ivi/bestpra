class Api::V1::UsersController < ApplicationController

    def index
        # @ = .all
        render json: 'Usersindex'
    end

    def show
        # @ = Users.find()
        render json: 'Usersshow'
    end

    def create
        # @user = Users.new(params[:user])
        # if @user.save
        # #   flash[:success] = "Object successfully created"
        # #   redirect_to @user
        # else
        # #   flash[:error] = "Something went wrong"
        # #   render 'new'
        # end
        render json: 'Userscreate'
    end

    def update
        # @user = Users.find(params[:id])
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
        # @user = Users.find(params[:id])
        # if @user.destroy
        #     # flash[:success] = 'Object was successfully deleted.'
        #     # redirect_to users_url
        # else
        #     # flash[:error] = 'Something went wrong'
        #     # redirect_to users_url
        # end
        render json: 'Usersdestroy'
    end

    private



end