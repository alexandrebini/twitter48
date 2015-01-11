Rails.application.routes.draw do
  namespace :api, constraints: { format: 'json' } do
    resource :timelines, only: [:show]
    resource :users, only: [:show]
    resources :followers, only: [] do
      collection do
        get :in_common
      end
    end
  end

  root 'application#index'
  get '(*params)', to: 'application#index'
end