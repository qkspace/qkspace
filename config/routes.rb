Rails.application.routes.draw do
  root to: 'projects#index'

  devise_for :users

  resources :projects do
    resources :pages, param: :slug, path: 'p' do
      resources :blocks
    end
  end
end
