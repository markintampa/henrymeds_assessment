Rails.application.routes.draw do
  resources :appointment_slots
  put "/appointment_slots/:id/confirm", to: "appointment_slots#confirm"
  resources :clients
  resources :providers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
