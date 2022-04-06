Rails.application.routes.draw do
  root to: "static#home"
  scope '/api' do
    resources :sessions, only: [:create]
    resources :registrations, only: [:create]
    resources :comments, only: [:create, :show, :update, :destroy]
    resources :recipes
    resources :ingredients
    resources :recipe_ingredients
    resources :votes, only: [:create, :destroy]
    post "fetch_votes/:id", to: "votes#show"
    delete :destroy_instruction, to: "recipes#destroy_instruction"
    delete :destroy_ingredient, to: "recipes#destroy_ingredient"
    post :recipes_query, to: "recipes#query"
    delete :logout, to: "sessions#logout"
    get :logged_in, to: "sessions#logged_in"
    post :forgot_password, to: "passwords#forgot"
    post :reset_password, to: 'passwords#reset'
  end

  get '*path', to: "application#fallback_index_html", constraints: ->(request) do
    !request.xhr? && request.format.html?
  end
end
