Rails.application.routes.draw do

  devise_for :admins

  resources :posts do
    collection do
      get :admin
    end
    resources :comments, only: [:index, :create]
  end

  root to: "posts#index"

  namespace :api do
    namespace :v1 do
      get '/news' => 'news#index'
      post '/news' => 'news#create'
      get '/news/:id' => 'news#show'
      patch '/news/:id' => 'news#update'
      delete '/news/:id' => 'news#destroy'

      get '/news/:id/comments' => 'news#comment_index'
      post '/news/:id/comments' => 'news#comment_create'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
