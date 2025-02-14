Rails.application.routes.draw do
  get "likes/create"
  get "likes/destroy"
  root "home#index"
  devise_for :users
  resources :profiles, only: [ :show, :edit, :update ]
  resources :questions do
    resources :answers, only: [ :create, :destroy, :edit, :update ] do
      resource :likes, only: [ :create, :destroy ]
    end
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
