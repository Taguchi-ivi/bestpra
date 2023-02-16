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
      resources :users, only: [:index, :show, :create , :edit, :update, :destroy]

      # auth_token
      # on collection => user_idがなくてもリクエストが可能に
      resources :auth_token, only:[:create] do
        post :refresh, on: :collection
        delete :destroy, on: :collection
      end

      # projects authenticateメソッド検証用
      resources :projects, only:[:index]

    end

    # helth check
    get :health_check, to: 'health_check#index'
  end


end
