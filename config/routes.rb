Rails.application.routes.draw do
  root 'activities#index'
  resources :records
  resources :activities do
    collection do
      get "cycle_duration"
      delete "archive_old"
      delete "delete_all"
    end
  end

  resources :recurring_tasks do
    put 'complete', on: :member
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
