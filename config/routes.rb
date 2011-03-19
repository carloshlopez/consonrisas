Prueba::Application.routes.draw do
  devise_for :members
  
  #
  # Admin
  #
  get "admin/index"
  match 'admin/', :controller => 'admin', :action => 'index'
  match 'admin/db/:table_name.:format', :controller => 'admin', :action => 'get_table_data'  
  match 'admin/db/:table_name/:id', :controller => 'admin', :action => 'update_table_data', :conditions => {:method => :put }  
  match 'admin/db/:table_name', :controller => 'admin', :action => 'create_table_data', :conditions => {:method => :post}


  

  post "events/add_facilitator"
  post "events/add_fundation"
  post "events/add_provider"
  post "events/add_show"  
  
  #add post!!
  get "fundations/add_follower"
  get "fundations/remove_follower"
  
  post "providers/add_follower"
  post "providers/remove_follower"
  
  get "facilitators/add_follower"
  get "facilitators/remove_follower"
  
  post "fundations/ask_admin"
  
  post "members/respond_admin"

  root :to => "home#index"
  
  get "home/info"
  post "home/feedback"
  
  resources :events do
    resources :comments
  end
  
  resources :facilitators
  
  resources :roles

  resources :members do
#    resources :contact_informations
    post "update_facebook_id"
  end

  resources :populations

  resources :providers do
    resources :shows
    resources :contact_informations
  end

  resources :fundations do
    resources :contact_informations
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
