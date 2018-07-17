Rails.application.routes.draw do
  root 'activities#index'
  resources :records
  resources :activities
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
