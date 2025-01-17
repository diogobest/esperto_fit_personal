Rails.application.routes.draw do
  devise_for :accounts
  resources :units, only: %i[ index show ]
  resources :customers, only:%i[] do
    post 'add_unit', on: :member
  end
  resources :profiles, only: %i[index new create show edit update] do
    get 'payments', on: :member
  end
  resources :units, only: %i[index show]
  resources :personals, only: %i[index new create edit]
  resources :schedules, only:%i[new create edit update ]
  resources :plans, only: %i[ new create ]
  resources :appointments, only:%i[show] do
    get 'view', on: :member
    post 'enroll', on: :member
  end
  resources :accounts, only:%i[show]

  root to: 'home#index'
  get '/my_schedule', to: 'schedules#my_schedule'
  resources :accounts, only:%i[show]

  namespace 'api' do
    namespace 'v1' do
      get '/search/account', to: 'accounts#search'
      get '/personals', to: 'personals#index'
      get '/search/customer', to: 'customers#search'

      resources :units, only: %i[] do
        get '/personals', on: :member, action: 'personals'
      end

    end
  end
end
