ActionController::Routing::Routes.draw do |map|

  map.login '/login', :controller => 'user_sessions', :action => 'create', :conditions => {:method => [:put, :post]}
  map.login '/login', :controller => 'user_sessions', :action => 'new', :condiions => {:method => [:get]}
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'

  map.signup '/signup', :controller => 'users', :action => 'new', :condiions => {:method => [:get]}
  map.signup '/signup', :controller => 'users', :action => 'create', :conditions => {:method => [:put, :post]}

  map.invite '/invite/:invite_id/:id', :controller => 'users', :action => 'activate'

  map.resource :user_session
  map.resource :account, :controller => 'users'
  # map.resources :users

  map.dashboard '/dashboard', :controller => 'home', :action => 'index'
  map.root :controller => 'home', :action => 'index'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end
