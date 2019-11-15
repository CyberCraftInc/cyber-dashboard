Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, path: '',
                     controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' },
                     path_names: { sign_in: 'login', sign_out: 'logout' }
  root to: 'users#index'
  resources :users, only: %i[edit update show index create]
  resources :users, only: [] do
    get '/calendar.ics' => 'users#ics_export', :as => 'ics_export'
  end
  resources :projects, only: %i[show]
  resources :events, only: %i[create update]
  resources :targets, only: [] do
    put 'toggle_achieved', on: :member
  end
end
