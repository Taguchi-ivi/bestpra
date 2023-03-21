class Api::V1::CommentsController < ApplicationController
    # before_action :authenticate_user
    before_action :authenticate_active_user

    def create
        article = Article.find(params[:article_id])
        comment = article.comments.new(comment_params)
        comment.user_id = current_user.id
        if comment.save
            article.create_notification_comment!(current_user, comment.id)
            render json: comment.as_json(), status: :ok
        else
            render json: comment.errors.full_messages, status: :unprocessable_entity
        end
    end

    def destroy

        comment = Comment.find(params[:id])
        article = comment.article
        # return render status: :bad_request  unless comment.user_id == current_user.id
        return render json: :bad_request  unless comment.user_id == current_user.id
        if comment.destroy!
            article.delete_notification_comment!(current_user, comment.id)
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