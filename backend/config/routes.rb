Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # add
  namespace :api do
    # namespace :v1 do
    namespace :v1, default: { format: :json } do
      # api test action
      resources :hello,only: [:index]

      # users
      # index不要かも
      # resources :users, only: [:index, :show, :create , :edit, :update, :destroy]
      resources :users, only: [:index, :show] do
        # resource :users, only: [:edit]
        get :edit, on: :collection
        patch :update, on: :collection
        patch :update_avatar, on: :collection
      end

      # auth_token, 認証周り
      # on collection => user_idがなくてもリクエストが可能に
      resources :auth_token, only:[:create, :destroy] do
        # delete :destroy, on: :collection
        post :login, on: :collection
        post :refresh, on: :collection
        delete :logout, on: :collection
        patch :update_email, on: :collection
        patch :update_password, on: :collection
      end

      # TODO 今後不要に:projects authenticateメソッド検証用
      resources :projects, only:[:index]

      # articles
      resources :articles, only:[:index, :show, :edit, :update, :create, :destroy] do
        get :article_about, on: :collection
      end

      # MSTデータ取得
      # resources :mst_lists, only:[:index]

      # MSTデータ取得
      resources :level_lists, only:[:index, :create]
      resources :tag_lists, only:[:index, :create]

      # タグ情報を更新する
      resources :tag_maps, only:[:update, :create]

    end

    # helth check
    get :health_check, to: 'health_check#index'
  end


end
