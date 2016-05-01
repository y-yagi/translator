Rails.application.routes.draw do
  resources :edicts, only: [:index, :show]
end
