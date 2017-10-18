Rails.application.routes.draw do


  # root 'home#landing'
  # root 'photos#index'
  root 'profiles#show'
  devise_for :users

  resources :users, only: [:show, :update], controller: :profiles

  resources :likes
  resources :followers
  # or just resource :profiles
  # resources :profiles
  resource :profile

  resources :photos do
      resources :comments
  end

  post ':username/follow_user', to: 'relationships#follow_user', as: :follow_user

  get 'relationships/follow_user'

  get 'relationships/unfollow_user'

  post ':username/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user

  get 'top/index'

  # localhost:3000/:user.email
  # get ':user.email', to: 'profiles#show', as: :profile

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
