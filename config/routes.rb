Rails.application.routes.draw do
  resources :projects do
    resources :pages do
      resources :blocks
    end
  end
end
