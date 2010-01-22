# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user

  before_filter :app_init
  

protected

  # Initializer for specific app to-dos
  def app_init
    # stuff goes here
  end

  # Check which environments we are in
  def dev?; ENV['RAILS_ENV'] == 'development'; end
  def prod?; ENV['RAILS_ENV'] == 'production'; end
  helper_method :dev?, :prod?


  # The gag, the error page to display
  def render_joke(*args)
    opts = {:action => "error_pages/#{configatron.current_error_page}"}.merge(args.extract_options!)
    render opts
  end

  def is_file?(path, file = false); File.exist?( (RAILS_ROOT + '/' + path + (!file.blank? ? "/#{file}" : '')).gsub(/(\?)(.*)$/, '').gsub(/\/\//, '/') ); end
  helper_method :is_file?


private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to login_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to account_url
      return false
    end
  end
  
  def store_location
    session[:return_to] = request.request_uri
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def record_not_found
    render :file => File.join(RAILS_ROOT, 'public', '404.html'), :status => 404
  end

end