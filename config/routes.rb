Rails.application.routes.draw do
  resources :my_pages, only: %i[index]
  resources :searches, only: %i[index show create destroy] do
    collection do
      get :favorite_register
      get :favorite_unregister
    end
  end

  resources :works do
    resources :technologies do
      collection do
        delete :reset
      end
      resources :pyramids
      resources :links do
        member do
          get :good_register
          get :good_unregister
        end
      end
    end
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  devise_scope :user do
    root 'users/sessions#new'
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    post 'users/general_sign_in', to: 'users/sessions#general_sign_in'
    get 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    get 'users/sign_out', to: 'devise/sessions#destroy'
  end
end
