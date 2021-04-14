Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'users/registrations'}
  get 'users/index'
  
  resources :tweets do
    post :retweet, to:'tweets/retweet'
    post :friend
    delete :unfriend
    resources :likes
  end
  
  root 'homes#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
