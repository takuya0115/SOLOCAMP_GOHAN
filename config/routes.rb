Rails.application.routes.draw do
  get 'searches/search'
  namespace :admin do
    root to: "admin/users#index"
    resources :users, only:[:show, :index, :edit, :update]do
      member do
        get :recipes
      end
    end
    resources :recipes, only: [:index, :show, :edit, :update, :destroy]do
      resources :comments, only: [:destroy]
    end
  end

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: 'users/sessions'
  }

  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  root to: "users/homes#top"

  scope module: :users do
    resources :users, only: [:index, :show, :edit, :update]do
      member do
        get :favorites
        get :recipes
      end
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    get 'users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch 'users/:id/withdraw' => 'users#withdraw', as: 'withdraw'
    resources :recipes, only: [:index,:show,:edit,:create,:destroy,:update]do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
  end

  get '/search', to: 'searches#search'

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
