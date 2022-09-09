Rails.application.routes.draw do

  root to: 'homes#top'
  get 'about' => 'homes#about'

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  # ゲストログイン
  devise_scope :user do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end


  namespace :admin do
    resources :tags, only: [:index, :create, :edit, :update]
    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      # ユーザーの投稿一覧
      member do
        get :posts
      end
    end

    resources :posts,only: [:index, :show, :destroy] do
      resources :post_comments, only: [:destroy]
    end
  end


  scope module: :public do
    resources :users, only: [:show, :edit, :update, :destroy] do
      get '/unsubscribe' => 'users#unsubscribe'
      # ブックマークした投稿一覧表示
      member do
        get :bookmarks
      end
    end
    resources :posts do
      resource :bookmarks, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    get '/search' => 'posts#search'
    get '/search/index' => 'posts#search_index'
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
