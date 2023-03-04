class Api::V1::CommentsController < ApplicationController
    before_action :authenticate_user

    # before_action :set_article, only: [:edit, :update]

    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.new(comment_params)
        @comment.user_id = current_user.id
        if @comment.save
            # render json: @comment.as_json(include: [
            #                                 {user: { only: [:id, :nickname, :avatar]}},
            #                                 {level_list: { only: [:id, :name]}},
            #                                 {tag_list: { only: [:name]}}
            #                             ]), status: :ok
            render json: @comment.as_json(), status: :ok
        else
            render json: @comment.errors.full_messages, status: :unprocessable_entity
        end
    end

    def destroy

        comment = Comment.find(params[:id])
        return render json: :bad_request unless comment.user_id == current_user.id
        if comment.destroy!
            render json: {message: 'コメントを削除しました'}, status: :ok
        else
            render json: {message: 'コメントの削除に失敗しました'}, status: :bad_request
        end

    end

    private
        def comment_params
            params.require(:comment).permit(:content)
        end

end