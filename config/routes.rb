Rails.application.routes.draw do
  root to: 'projects#index'

  resources :projects do
    resources :pages do
      resources :blocks
    end
  end
end
