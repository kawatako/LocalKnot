Rails.application.routes.draw do
  root "home#index"

  devise_for :users
  resource :profile, only: [ :show, :edit, :update ]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
