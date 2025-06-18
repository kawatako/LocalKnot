Rails.application.routes.draw do
  root "home#index"
  devise_for :users
  resources :profiles, only: [ :show, :edit, :update ]
  resources :questions do
    resources :answers, only: [ :create, :destroy, :edit, :update ] do
      resource :likes, only: [ :create, :destroy ]
    end
    member do
      patch :choose_best_answer
      patch :remove_best_answer
    end
  end

  resources :blogs
  resources :images, only: [ :new, :create, :destroy, :index ]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
