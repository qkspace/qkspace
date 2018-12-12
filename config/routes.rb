class PublicConstraint
  # We want to consider request private by default, and public
  # if it qualifies
  def self.matches?(request)
    request.env['qkspace.area'][:kind] == :public
  end
end

class PrivateConstraint
  def self.matches?(request)
    !PublicConstraint.matches?(request)
  end
end


Rails.application.routes.draw do
  constraints(PublicConstraint) do
    scope module: 'public', as: 'public' do
      root to: 'projects#show'

      resources :pages, param: :slug, path: '', only: %i[index show] do
        member do
          get :next
          get :previous
        end
      end
    end
  end

  constraints(PrivateConstraint) do
    scope module: 'private', as: 'private' do
      root to: 'projects#index'

      resources :projects do
        get :check_slug, on: :collection

        resource :domain, only: %i[create destroy edit]

        resources :pages do
          member do
            post :move
            get  :next
            get  :previous
          end
        end

        resources :project_collaborations, as: :collaborators, path: :collaborators, only: %i[create destroy index]
      end
    end

    resource :users, only: %i[create new edit update destroy]

    # If you change this — change robots.txt as well
    get 'sign_in', to: 'sessions#new'
    post 'sign_in', to: 'sessions#create'
    get 'sign_in/:token', to: 'sessions#show', as: :token_sign_in
    match 'sign_out', to: 'sessions#destroy', via: %i[get delete]
  end

  root to: proc { [404, {}, []] }
end
