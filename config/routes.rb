Rails.application.routes.draw do
  root to: 'projects#index', constraints: {subdomain: ''}
  root to: 'projects#show', constraints: {subdomain: /.+/}

  devise_for :users

  resources :projects, only: [:new, :index, :create, :edit, :update, :destroy]

  resources :pages, param: :slug, path: '' do
    resources :blocks

    member do
      post :move
    end
  end
end
