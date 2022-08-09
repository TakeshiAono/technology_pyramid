Rails.application.routes.draw do
  get 'searches/index'
  resources :links
  resources :pyramids
  resources :technologies
  resources :my_pages do
    collection do
      get 'search'
    end
  end
  resources :works
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  root "works#index"
end
