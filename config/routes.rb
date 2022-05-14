# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'static#home'
  scope '/api' do
    resources :sessions, only: [:create]
    resources :registrations, only: [:create]
    resources :comments, only: %i[create show update destroy]
    resources :recipes
    resources :ingredients
    resources :recipe_ingredients
    resources :votes, only: %i[create destroy]

    # recipes routes
    post 'recipes/:id', to: 'recipes#show'
    post :recipe_feed, to: 'recipes#index'
    delete :destroy_instruction, to: 'recipes#destroy_instruction'
    delete :destroy_ingredient, to: 'recipes#destroy_ingredient'
    delete 'recipes/photos/:id', to: 'recipes#destroy_photo'
    post :recipes_mailer, to: 'recipes#email_recipe_to_user'
    post :recipes_query, to: 'recipes#query'

    # user routes
    post 'users', to: 'users#show'
    put 'users/:id', to: 'users#update'
    post :forgot_password, to: 'passwords#forgot'
    post :reset_password, to: 'passwords#reset'

    # sessions routes
    delete :logout, to: 'sessions#logout'
    get :logged_in, to: 'sessions#logged_in'

    # votes routes
    post 'fetch_votes/:id', to: 'votes#show'

    # comment routes
    post 'fetch_comment', to: 'comments#fetch_comment'
  end

  get '*path', to: 'application#fallback_index_html', constraints: lambda { |request|
    !request.xhr? && request.format.html?
  }
end
