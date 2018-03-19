Rails.application.routes.draw do

  devise_for :admins

  resources :posts do
    collection do
      get :admin
    end
    resources :comments, only: [:index, :create]
  end

  root to: "posts#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
