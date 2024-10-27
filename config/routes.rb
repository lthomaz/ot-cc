Rails.application.routes.draw do
  resources :pay_rates, only: [ :create, :update ] do
    get :payment, on: :member
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
