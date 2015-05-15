Rails.application.routes.draw do
  get 'trips/index'

  root to: "trips#index"

  resources :trips, only: [:create, :index, :show, :new, :update, :edit]



  resources :hunts do
    resources :questionsets, only: [:show, :index, :new, :create, :update, :edit]
  end



end
