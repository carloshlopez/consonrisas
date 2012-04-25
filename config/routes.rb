Consonrisas::Application.routes.draw do
  
  resources :need_categories

  get "need/create"

  get "need/destroy"
  
  get "project_need/create"

  get "project_need/destroy"

  resources :news

  get "search/find"

  match '/auth/facebook/logout' => 'application#facebook_logout', :as => :facebook_logout
  match '/auth/:provider/callback' => 'authentications#create'
  match '/auth/failure' => 'users/authentications#failure'
  
  resources :authentications

  devise_for :members, :controllers => {:registrations => 'registrations'}
  #
  # Admin
  #
  get "admin/index"
  match 'admin/', :controller => 'admin', :action => 'index'
  match 'admin/db/:table_name.:format', :controller => 'admin', :action => 'get_table_data'  
  match 'admin/db/:table_name/:id', :controller => 'admin', :action => 'update_table_data', :conditions => {:method => :put }  
  match 'admin/db/:table_name', :controller => 'admin', :action => 'create_table_data', :conditions => {:method => :post}
  match 'admin/db/delete/:table_name/:id', :controller => 'admin', :action => 'delete_table_data', :conditions => {:method => :delete }    
  get "admin/members_to_csv" =>"admin#members_to_csv"
  
  get "admin/dj_all", :as => :dj_all

  get "admin/dj_show/:id"=> "admin#dj_show"

  get "admin/dj_destroy/:id" => "admin#dj_destroy"
  

  get "events/gallery"

  post "events/add_facilitator"
  post "events/add_fundation"
  post "events/add_provider"
  post "events/add_show"  
  
  post "events/remove_facilitator"
  post "events/remove_fundation"
  post "events/remove_provider"  
  
  post "fundations/add_follower"
  post "fundations/remove_follower"
  post "fundations/send_msg_to_admins"    
  
  post "providers/add_follower"
  post "providers/remove_follower"
  post "providers/send_msg_to_admins"  
  
  post "facilitators/add_follower"
  post "facilitators/remove_follower"
  post "facilitators/send_msg"
  
  post "fundations/ask_admin"
  post "providers/ask_admin"  
  post "events/ask_admin"  
  
  post "members/respond_fundation_admin"
  post "members/respond_provider_admin"
  post "members/respond_event_admin"    
  post "members/delete_alert"      

  root :to => "home#new_index"
  #root :to => "home#index"
  
  get "/info" =>"home#info"
  get "/touch" =>"home#touch"
  get "/donate" =>"home#donate"  
  get "/allies" =>"home#allies"
  get "home/new_index"
  get "home/event_comments"
  get "/social" => "home#social"
  post "home/feedback"
  post "/cleanInitialSession" => "members#cleanInitialSession"
  
  get 'photos/poll'
  

  
  match 'needs/complete/:id' => 'needs#complete'

  get "/facilitators/list" => "facilitators#list"  
 

  
  resources :roles

  resources :members do
    post "update_facebook_id"
    put "change_pic"  
  end
  post "/members_register" => "members#register"

  resources :populations


  match "project_needs/all_needs", :as => "all_needs"

  localized(['es', 'en'], :verbose => true) do
    resources :events do
      get 'show_gallery'
      resources :photos
      resources :comments
      resources :needs do
          post "complete"
      end
    end  
    resources :facilitators
    resources :providers do
      get "get_pic"
      put "change_pic"
      resources :shows
      resources :contact_informations
    end
    resources :fundations do
      put "change_pic"    
      resources :contact_informations
      resources :project_needs    
    end
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
