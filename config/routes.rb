Rails.application.routes.draw do
  scope '/api' do
    resources :sessions, only: [:create]
    resources :registrations, only: [:create]
    delete :logout, to: "sessions#logout"
    get :logged_in, to: "sessions#logged_in"
    post :forgot_password, to: "passwords#forgot"
    post :reset_password, to: 'password#reset'
    root to: "static#home"
  end

  get '*path', to: "application#fallback_index_html", constraints: ->(request) do
    !request.xhr? && request.format.html?
  end
end
