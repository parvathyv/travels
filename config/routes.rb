Rails.application.routes.draw do
  get 'trips/index'

  root to: "trips#index"

  resources :trips, only: [:create, :index, :show, :new, :update, :edit]



  resources :trips do
    resources :tripdetails, only: [:show, :index, :new, :create, :update, :edit, :destroy]
  end

  resources :tripdetails do
    resources :photos, only: [:show, :index, :new, :create, :update, :edit, :destroy]
  end

end
