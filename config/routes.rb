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

      resources :pages, param: :slug, path: '', only: [:index, :show]
    end
  end

  constraints(PrivateConstraint) do
    scope module: 'private', as: 'private' do
      root to: 'projects#index'

      resources :projects do
        get :check_slug, on: :collection

        resources :pages do
          member do
            post :move
          end
        end
      end
    end
  end

  devise_for :users, controllers: { registrations: "registrations" }

  root to: proc { [404, {}, []] }
end
