ActionController::Routing::Routes.draw do |map|

  # Sessions
  map.login '/login', :controller => 'user_sessions', :action => 'create', :conditions => {:method => [:put, :post]}
  map.login '/login', :controller => 'user_sessions', :action => 'new', :condiions => {:method => [:get]}
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'
  map.resource :user_session, :as => :session

  # Users
  map.signup '/signup', :controller => 'users', :action => 'new', :condiions => {:method => [:get]}
  map.signup '/signup', :controller => 'users', :action => 'create', :conditions => {:method => [:put, :post]}
  map.resource :account, :controller => 'users'

  # Invites
  map.resource :invite
  map.activte_invite '/invite/:invite_id/:id', :controller => 'invites', :action => 'activate'

  # Home
  map.dashboard '/dashboard', :controller => 'home', :action => 'index'
  map.root :controller => 'home', :action => 'index'

  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'

end
