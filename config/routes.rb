Bluemoonlist::Application.routes.draw do

  devise_for :users, controllers: { registrations: "registrations",
    omniauth_callbacks: "users/omniauth_callbacks" }
  get "/users", to: "users#index"
  get "/users/profile/:id", to: "users#profile", as: :profile
  get "/feed", to: "static#feed", as: :feed
  get "/static/home"
  get "/static/about"
  resources :categories
  resources :requests, except: [:new]
  root :to => "static#home"

  # Twilio requests
  post "/twilio/provider_status_callback", to: "twilio#provider_status_callback"
  post "/twilio/user_status_callback", to: "twilio#user_status_callback"
  post "/twilio/user_provider_twiml_callback", to: "twilio#user_provider_status_callback"
  post "/twilio/provider_twiml/:id", to: "twilio#provider_twiml"
  post "/twilio/user_twiml", to: "twilio#user_twiml"
  post "/twilio/user_provider_twiml", to: "twilio#user_provider_twiml"
  post "/twilio/provider_gather", to: "twilio#provider_gather"
  post "/twilio/user_gather", to: "twilio#user_gather"


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end
  
  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
