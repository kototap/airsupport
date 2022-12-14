Rails.application.routes.draw do
  namespace :admin do
    get "homes/top"
  end
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }

  devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: "public/sessions"
  }

  # ゲストログイン
  devise_scope :user do
    post "public/guest_sign_in", to: "public/sessions#guest_sign_in"
  end


  namespace :admin do
    get "/" => "homes#top"
    resources :tags, only: [:index, :create, :edit, :update]
    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      # ユーザーの投稿一覧
      member do
        get :posts
      end
    end

    resources :posts, only: [:index, :show, :destroy] do
      resources :post_comments, only: [:destroy]
    end
  end


  scope module: :public do
    root to: "homes#top"
    get "/about" => "homes#about"

    resources :users, only: [:show, :edit, :update, :destroy] do
      get "/unsubscribe" => "users#unsubscribe"
      # ブックマークした投稿一覧表示
      member do
        get :bookmarks
      end
    end

    resources :posts do
      resource :bookmarks, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
      # 下書き一覧
      collection do
        get "draft_index"
      end
    end
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
