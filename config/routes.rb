Rails.application.routes.draw do
  get 'api/news', to: 'api#index'
  get 'api/:start_date/:end_date', to: 'api#show'
  post 'api/tweets', to: 'api#create'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  devise_for :users, controllers: {registrations: 'users/registrations'}
  get 'users/index'
  
  resources :tweets do
    post :retweet, to:'tweets/retweet'
    post :friend
    delete :unfriend
    resources :likes
  end
  
  get '/tweets/hashtag/:name', to: 'tweets#hashtags'
  
  root 'homes#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
