ActionController::Routing::Routes.draw do |map|
  map.resources :t_appliedjobs

  map.resources :t_joboffers
  map.resources :t_appliedjobs

  map.resources :employers, :only => [:index, :show, :new ,:edit, :create , :update, :destroy, :update_password]
  map.resources :jobseekers, :get => :index , :on => :collection

  #map.resources :jobseekers, :collection => { :search => :get }
  map.search_jobseeker 'search_jobseeker_path', :controller => "jobseekers", :action => "search"
  #map.index_jobseeker "index_jobseeker_path", :controller => "jobseekers" , :action => "index"

  map.resources :sessions, :only => [:new, :create, :destroy_employer, :destroy_jobseeker]
  map.root :controller => 'home_page', :action => 'home'

  map.resources :employer_new_password, :only => [:edit, :update]
  # The priority is based upon order of creation: first created -> highest priority.
  map.resources :employer_password, :only => [:new, :update]

  map.sign_up "sign_up_path", :controller => "home_page", :action => "sign_up"
  map.sign_in "sign_in_path", :controller => "sessions", :action => "new"
  map.connect "/sign_out_employer_path", :controller => "sessions", :action => "destroy_employer"
  map.connect "/sign_out_jobseeker_path", :controller => "sessions", :action => "destroy_jobseeker"

  map.connect "/t_joboffer_path", :controller => "t_joboffers", :action => "new"
  map.show_joboffer "/show_joboffer_path", :controller => "t_joboffers", :action => "show"
  map.search_job "/search_job_path", :controller => "t_joboffers", :action => "index"

  map.appliedjob "/appliedjob_path", :controller => "t_appliedjobs", :action=> "show"

  map.resources :password_reset_tokens, :only => [:new, :create, :edit, :update ]
  #map.connect '/new_password_reset_token', :controller => 'password_reset_tokens', :action => 'new'
  #map.connect '/edit_password_reset_token', :controller => 'password_reset_tokens', :action => 'edit'
  #map.edit_password_reset_token '/edit_password_reset_token_path', :controller => 'password_reset_tokens', :action => 'edit'
  
 

  map.newpassword '/newpassword', :controller => 'employers', :action => "update_password" 
  map.jobseeker_newpassword '/jobseeker_newpassword', :controller => 'jobseekers', :action => 'update_password'

  map.employer_new_password '/employer_new_password', :controller => 'employer_new_password', :action => 'edit'
  map.edit_employer "edit_employer_path", :controller => 'employers', :action => 'edit'
  map.edit_jobseeker "edit_jobseeker_path", :controller =>"jobseekers", :action =>'edit'
  map.connect '/employer_password', :controller => 'employer_password', :action => 'new'
  #map.resources :t_joboffers, :only => [:create, :destroy]

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
