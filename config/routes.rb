Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  resources :users, except: [:destroy] do
    resources :admins, only: [:index, :new, :create, :destroy]
  end
  resources :sessions, only: [:create]
  resources :categories
  resources :articles do
    resources :comments, except: [:new, :index]
  end

  root 'categories#index'

  get '/sessions' => 'sessions#new', as: :new_session
  delete "/sessions" => 'sessions#destroy', as: :logout
end
