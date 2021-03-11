Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homepage#index'

  namespace :api do
    namespace :v01 do
      resources :ufo_sightings, only: %i[create index], defaults: { format: :json }
    end
  end

end