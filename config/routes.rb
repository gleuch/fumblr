ActionController::Routing::Routes.draw do |map|

  map.resource :user_session
  map.resource :account, :controller => 'users'
  map.resources :users

  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.invite '/invite/:invite_id/:id', :controller => 'users', :action => 'activate'

  map.dashboard '/dashboard', :controller => 'home', :action => 'index'
  map.root :controller => 'home', :action => 'index'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end
