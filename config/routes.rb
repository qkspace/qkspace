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
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
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

    get 'sign_in/:token', to: 'session/user_tokens#show'
    get 'sign_in/secret/:token', to: 'session/project_secret_tokens#show'
    match 'sign_out', to: 'sessions#destroy', via: %i[get delete]
  end

  constraints(PrivateConstraint) do
    scope module: 'private', as: 'private' do
      root to: 'projects#index'

      resources :projects do
        get :check_slug, on: :collection
        get :redirect_to_public, on: :member

        resources :pages do
          resources :discussions

          member do
            post :move
            get  :next
            get  :previous
          end
        end

        # sidebar in project settings
        resource :domain, only: %i[create destroy edit]
        resources :project_collaborations, as: :collaborators, path: :collaborators, only: %i[create destroy index]
        member do
          get :discussion_settings
        end
      end
    end

    resource :users, only: %i[create new edit update destroy]

    # If you change anything below — change robots.txt as well

    scope module: 'session' do
      get 'sign_in', to: 'user_tokens#new'
      post 'sign_in', to: 'user_tokens#create'
      get 'sign_in/:token', to: 'user_tokens#show', as: :token_sign_in
    end

    match 'sign_out', to: 'sessions#destroy', via: %i[get delete]
    delete 'sign_out_everywhere', to: 'sessions#sign_out_everywhere'
  end

  root to: proc { [404, {}, []] }
end
