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
    # Display error page
    render_error_page if session[:error_page]
  end

  # Check which environments we are in
  def dev?; ENV['RAILS_ENV'] == 'development'; end
  def prod?; ENV['RAILS_ENV'] == 'production'; end
  helper_method :dev?, :prod?


  # The gag, the error page to display
  def render_error_page(*args)
    set_error_page_session
    eval_error_page_session

    opts = {:template => "error_pages/#{configatron.current_error_page}"}.merge(args.extract_options!)
    render opts
  end
  def redirect_error_page_back_or_default(to = :back)
    set_error_page_session
    redirect_back_or_default(root_path)
  end
  def redirect_error_page_to(url)
    set_error_page_session
    redirect_to url
  end


  def is_file?(path, file = false); File.exist?( (RAILS_ROOT + '/' + path + (!file.blank? ? "/#{file}" : '')).gsub(/(\?)(.*)$/, '').gsub(/\/\//, '/') ); end
  helper_method :is_file?


private

  def set_error_page_session
    session[:error_page] ||= true
    session[:error_page_count] ||= 0
  end

  def eval_error_page_session
    return unless session[:error_page]
    session[:error_page_count] += 1

    if configatron.error_page_limit && configatron.error_page_limit.to_i != 0 && session[:error_page_count].to_i >= configatron.error_page_limit.to_i
      session.delete(:error_page)
      session.delete(:error_page_count)
    end
  end    

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
  
  def redirect_back_or_default(default = :back)
    redirect_to(session[:return_to] || default || root_url)
    session[:return_to] = nil
  end

  def record_not_found
    render :file => File.join(RAILS_ROOT, 'public', '404.html'), :status => 404
  end

end