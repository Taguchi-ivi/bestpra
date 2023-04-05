class Api::V1::ArticlesController < ApplicationController
    # before_action :authenticate_user, except: [:article_about]
    before_action :authenticate_active_user, except: [:article_about]

    def index
        articles = Article.includes(:user, :likes, :level_list, :tag_list, comments: :user)
                            .as_json(include: [
                                        {user: { only: [:id, :nickname, :avatar]}},
                                        {likes: { only: [:user_id]}},
                                        {level_list: { only: [:id, :name]}},
                                        {tag_list: { only: [:id, :name]}},
                                        {comments: { include: [
                                            user: { only: [:id, :nickname, :avatar] },]}},
                                    ])
        render json: articles
    end

    def show
        # オーバーライドしたレコードを取得 ※article modelも修正が必要
        # render json: Article.find(params[:id]).as_json
        article = Article.includes(:user, :likes, :level_list, :tag_list, comments: :user)
                            .find(params[:id])
                            .as_json(include: [
                                        {user: { only: [:id, :nickname, :avatar]}},
                                        {likes: { only: [:user_id]}},
                                        {level_list: { only: [:id, :name]}},
                                        {tag_list: { only: [:id, :name]}},
                                        {comments: { include: [
                                            user: { only: [:id, :nickname, :avatar] },]}},
                                    ])
        render json: article

    end

    # 自身のいいねした記事のIDのみ取得
    def current_liked
        current_liked = current_user.likes.pluck(:article_id)
        likes = Article.includes(:likes)
                            .as_json(include: [
                                        {likes: { only: [:user_id]}},
                                    ])
        render json: {currentLiked: current_liked, likes: likes}
    end

    # aboutページ用の3件のarticleを取得
    # いいねの多い記事3件を取得 ※ default_scopeでいいねの多い順が正しく反映されない為、ここだけスキップするunscoped
    def article_about
        likes_id = Article.unscoped
                            .joins(:likes)
                            .group('articles.id')
                            .order('COUNT(likes.id) DESC,articles.created_at DESC')
                            .limit(3)
                            .pluck(:id)
        articles = Article.includes(:user, :likes, :level_list, :tag_list, :comments)
                            .where(id: likes_id)
                            .as_json(include: [
                                        {user: { only: [:id, :nickname, :avatar]}},
                                        {likes: { only: [:user_id]}},
                                        {level_list: { only: [:id, :name]}},
                                        {tag_list: { only: [:id, :name]}},
                                        {comments: { only: [:id]}},
                            ])
        render json: articles
    end

    def search
        keyword = params[:keyword]
        return render json: [] if keyword.blank?
        articles = Article.includes(:user, :likes, :level_list, :tag_list, comments: :user)
                            .where('title LIKE ? OR content LIKE ?', "%#{keyword}%", "%#{keyword}%")
                            .as_json(include: [
                                        {user: { only: [:id, :nickname, :avatar]}},
                                        {likes: { only: [:user_id]}},
                                        {level_list: { only: [:id, :name]}},
                                        {tag_list: { only: [:id, :name]}},
                                        {comments: { only: [:id]}},
                            ])
        render json: articles
    end

    # 作成者本人か確認
    def edit
        # return render status: :bad_request if not_current_user_for_article(params[:id])
        return render json: :bad_request if not_current_user_for_article(params[:id])
        article = Article.find(params[:id])

        render json:  article.as_json(include: [
                                {tag_list: { only: [:name]}}
                                ]), status: :ok
    end

    def update
        # return render status: :bad_request if not_current_user_for_article(params[:id])
        return render json: :bad_request if not_current_user_for_article(params[:id])
        # article = Article.find(params[:id])
        # if article.update!(article_params)
        article = Article.find(params[:id])
        article.assign_attributes(article_params)
        article.sanitize_content
        if article.save
            # 人が多くなったら不要になったタグを削除する ※ロジックの記載場所は考えること
            # old_tag_list = @article.tag_list
            # delete_tag_list(old_tag_list) unless old_tag_list.empty?

            # タグ情報も作成する
            new_tag_list = params[:article][:tag_list].split(',')
            article.delete_tag_map
            article.save_tags(new_tag_list) unless new_tag_list.empty?
            render json: article
        else
            render json: article.errors.full_messages
        end
    end

    def create
        # tag情報も作成する
        article = current_user.articles.build(article_params)
        article.sanitize_content
        if article.save!

            # タグ情報も作成する
            tag_list = params[:article][:tag_list].split(',')
            article.save_tags(tag_list) unless tag_list.empty?

            render json: article
        else
            # render json: @article.errors.full_messages
            render json: { errors: article.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        # return render status: :bad_request if not_current_user_for_article(params[:id])
        return render json: :bad_request if not_current_user_for_article(params[:id])
        article = current_user.articles.find(params[:id])
        if article.destroy!
            render status: :ok
        else
            render article.errors.full_messages
        end
    end

    private

        def article_params
            params.require(:article).permit(:title, :content, :image, :level_list_id)
        end

        def not_current_user_for_article(id)
            return true unless Article.exists?(id)
            return true unless current_user.id == Article.find(id).user_id
        end

        # 不要になったタグは削除する
        # def delete_tag_list(old_tag_list)
        #     old_tag_list.each do |old_tag_name|
        #         next if old_tag_name.empty?
        #         tag = TagList.find_by(name: old_tag_name)
        #         if TagMap.where(tag_list_id: tag.id).count == 0
        #             TagList.where(tag_id: tag.id).destroy_all
        #         end
        #     end
        # end

end