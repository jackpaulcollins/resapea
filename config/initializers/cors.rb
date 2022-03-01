Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "http://localhost:3000"
    resource "*", headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head],
    credentials: true
  end

 todo enter prod credentials
  allow do
    origin "https://resapea.herokuapp.com"
    resource "*", headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head],
    credentials: true
  end
end