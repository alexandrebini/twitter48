Rails.application.routes.draw do
  namespace :api, constraints: { format: 'json' } do
  end

  root 'application#index'
  get '(*params)', to: 'application#index'
end