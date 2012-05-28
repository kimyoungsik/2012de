Dreamkit::Application.routes.draw do


  get "networks/index"

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :admins, :path_prefix => 'd'
  devise_for :users, :path_prefix => 'd', 
                      :controllers => { :registrations => 'registrations', :sessions => "sessions", :passwords => "passwords" }
  
  resources :authentications
  resources :comments
  resources :dittos
  resources :home
  resources :friendships
  resources :kits
  resources :messages do
    get :autocomplete_user_name, :on => :collection
  end
  resources :message_participations
  resources :moims
  resources :networks
  resources :notifications
  resources :notification_settings, :only => [:create, :update] 
  resources :participations
  resources :photos
  resources :replies
  resources :seeds
  resources :supports
  resources :users do
    resources :photos
    get :autocomplete_network_name, :on => :collection  
  end
  resources :network_participations
  match '/kits/:id/view_all_comments', :to => 'kits#view_all_comments'
  match '/auth/:provider/callback' => 'authentications#create'
  match '/friends/:id' => 'users#friends'
  match '/pending_friends/:id' => 'users#pending_friends'
  match '/requested_friends/:id' => 'users#requested_friends'
  match '/notifications_reset_count' => 'notifications#reset_count'
  match '/import' => 'users#import'
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
     # match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'seeds#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
