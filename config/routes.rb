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
  resources :microposts, except: [:edit]
  resources :recommendations, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :ratings, only: [:create, :destroy]
  resources :providers, only: [:index, :show]
  post '/requests/callback', to: "requests#callback"
  root :to => "static#home"
  get "/request_histories", to: "request_histories#index"

  # Call Subsystem Routes
  resources :call_jobs, only: [:create, :update]

  post "/twilio/provider_twiml/:id", to: "twilio#provider_twiml"
  post "/twilio/provider_gather/:id", to: "twilio#provider_gather"
  post "/twilio/provider_status_callback/:id", to: "twilio#provider_status_callback"
  post "/twilio/end_call", to: "twilio#end_call"
  post "/twilio/provider_text_status_callback", to: "twilio#provider_text_status_callback"


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
