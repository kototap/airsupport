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
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end


  namespace :admin do
    resources :tags, only: [:index, :create, :edit, :update]
    resources :users, only: [:index, :show, :edit, :update, :destroy]

    resources :posts,only: [:index, :show, :destroy] do
      resources :post_comments, only: [:destroy]
    end
  end


  scope module: :public do
    # root to: 'homes#top'
    # get 'about' => 'homes#about'

    resources :users, only: [:show, :edit, :update, :destroy] do
      get '/unsubscribe' => 'users#unsubscribe'
    end
    resources :posts do
      resources :bookmarks, only: [:index, :create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
