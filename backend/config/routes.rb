Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # add
  namespace :api do
    namespace :v1, default: { format: :json } do

      # api test action
      resources :hello,only: [:index]

      # users
      # index不要かも
      resources :users, only: [:index, :show] do
        get :edit, on: :collection
        patch :update, on: :collection
        patch :update_avatar, on: :collection
        # フォローしたユーザーのIDを取得
        get :current_following, on: :collection
        # ユーザーのいいね一覧取得
        get :likes
        # ユーザーの記事一覧取得
        get :written_articles
        # ユーザー検索
        get :search, on: :collection

        # フォロー機能
        resources :relationships, only: [:create] do
          post :unfollow, on: :collection
          # ユーザーのフォロワー一覧取得
          get :followers, on: :collection
          # ユーザーのフォロー一覧取得
          get :following, on: :collection
        end
      end

      # フォローしたユーザの記事一覧取得
      resources :following_articles, only: [:index]

      # auth_token, 認証周り
      # on collection => user_idがなくてもリクエストが可能に
      resources :auth_token, only:[:create, :destroy] do
        # delete :destroy, on: :collection
        post :login, on: :collection
        post :guest, on: :collection
        post :refresh, on: :collection
        delete :logout, on: :collection
        patch :update_email, on: :collection
        patch :update_password, on: :collection
      end

      # articles
      resources :articles, only:[:index, :show, :edit, :update, :create, :destroy] do
        get :article_about, on: :collection
        # いいねした記事のIDを取得
        get :current_liked, on: :collection
        # search機能
        get :search, on: :collection

        # comments
        resources :comments, only:[:create, :destroy]
        # like
        resource :like, only:[:create, :destroy]
      end


      # Level(ラベル)データ取得
      resources :level_lists, only:[:index, :update, :create] do
        get :article_level
      end

      # Tagデータ取得
      resources :tag_lists, only:[:index, :update, :create] do
        get :article_tag
      end

      # タグ情報を更新する
      resources :tag_maps, only:[:update, :create]

      # 通知
      resources :notifications, only:[:index, :update] do
        get :read, on: :collection
        patch :all_update, on: :collection
      end

    end

    # helth check
    get :health_check, to: 'health_check#index'
  end


end
