Rails.application.routes.draw do
  resources :links
  resources :searches
  resources :pyramids
  resources :technologies
  resources :my_pages do
    collection do
      get 'search'
    end
  end
  resources :works
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
  }
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  devise_scope :user do
    root "users/sessions#new"
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    get 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    get 'users/sign_out', to: 'devise/sessions#destroy'
  end
end
