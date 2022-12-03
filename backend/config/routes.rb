Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  # add
  namespace :api do
    namespace :v1 do
      # api test action
      resources :hello,only:[:index]
    end
  end


end
