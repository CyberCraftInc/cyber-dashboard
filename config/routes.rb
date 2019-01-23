Rails.application.routes.draw do
  devise_for :users, path: '',
                     controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' },
                     path_names: { sign_in: 'login', sign_out: 'logout' }
  root to: 'users#index'
  resources :users, only: %i[edit update show index]

  get 'profile', action: :show, controller: 'users'

  resources :targets, only: [] do
    put 'toggle_achieved', on: :member
  end
end
