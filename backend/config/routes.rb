Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # add
  namespace :api do
    namespace :v1 do
      # api test action
      resources :hello,only:[:index]
    end

    # helth check
    get :health_check, to: 'health_check#index'
  end


end
