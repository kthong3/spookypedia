Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  resources :users, except: [:destroy] do
    resources :admins, only: [:index, :new, :create, :destroy]
  end
  resources :sessions, only: [:new, :create]
  resources :categories, except: [:edit, :update]
  resources :articles do
    resources :comments, except: [:new, :index, :show, :edit]
    resources :revisions, only: [:index]
  end

  root 'categories#index'

  delete "/sessions" => 'sessions#destroy', as: :logout
  patch '/articles/:article_id/revisions/:id' => 'revisions#revise', as: :revise

end
