Rails.application.routes.draw do
  root 'meals#index'

  get '/register', to: 'users#new'
  resources :users, only: [:show, :create, :edit, :update]

  get  '/login',  to: 'sessions#new'
  post '/login',  to: 'sessions#create'
  get  '/logout', to: 'sessions#destroy'

  resources :meals do
    member do
      post 'vote'
      delete 'vote/destroy', to: 'meals#vote_destroy'
    end
    resources :comments, only: [:create] do
      member do
        post 'vote'
        delete 'vote/destroy', to: 'comments#vote_destroy'
      end
    end
  end

  resources :foods do
    member do
      post 'vote'
      delete 'vote/destroy', to: 'foods#vote_destroy'
    end

    resources :comments, only: [:create] do
      member do
        post 'vote'
        delete 'vote/destroy', to: 'comments#vote_destroy'
      end
    end
  end
end
