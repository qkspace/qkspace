Rails.application.routes.draw do
  root to: 'projects#index'

  resources :projects do
    resources :pages, param: :slug, path: 'p' do
      resources :blocks
    end
  end
end
