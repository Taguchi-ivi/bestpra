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
      resources :users, only: [:index, :show, :destroy] do
        # resource :users, only: [:edit]
        get :edit, on: :collection
      end

      # auth_token, 認証周り
      # on collection => user_idがなくてもリクエストが可能に
      resources :auth_token, only:[:create] do
        post :login, on: :collection
        post :refresh, on: :collection
        delete :destroy, on: :collection
        # add
        # delete :logout, on: :collection
        post :update_email, on: :collection
        post :update_password, on: :collection
        delete :logout, on: :collection
      end

      # projects authenticateメソッド検証用
      resources :projects, only:[:index]

    end

    # helth check
    get :health_check, to: 'health_check#index'
  end


end
