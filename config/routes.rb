ActionController::Routing::Routes.draw do |map|  
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login  '/login',  :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  map.resources :users

  map.open_id_complete 'session', :controller => "sessions", :action => "create", :requirements => { :method => :get }
  map.resource :session

  # The priority is based upon order of creation: first created -> highest priority.

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

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "release"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.story 'release/show/:permalink', :controller => 'release', :action => 'show'
  map.story 'interview/show/:permalink', :controller => 'interview', :action => 'show'
  map.article 'article/show/:permalink', :controller => 'article', :action => 'show'
  map.tools 'resource/show/:permalink', :controller => 'resource', :action => 'show'
  map.packageit 'package/show/:permalink', :controller => 'package', :action => 'show'
  map.news 'news/show/:permalink', :controller => 'news', :action => 'show'
  map.events 'event/show/:permalink', :controller => 'event', :action => 'show'
  
  map.connect "logged_exceptions/:action/:id", :controller => "logged_exceptions"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
