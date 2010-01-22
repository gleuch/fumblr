
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')


Rails::Initializer.run do |config|
  config.action_controller.session = {
    :session_key => '_fumblr  ',
    :secret      => 'omgthisisMY111111weirdproject'
  }
  

  config.action_controller.session_store = :active_record_store

  config.time_zone = 'UTC'

  config.gem 'haml'
  config.gem 'RedCloth'
  config.gem 'configatron', :version => '>= 2.2.2'
  config.gem 'mislav-will_paginate', :version => '~> 2.3.8', :source => 'http://gems.github.com', :lib => 'will_paginate'
  
  config.gem 'norman-friendly_id', :lib => 'friendly_id', :source => 'http://gems.github.com'  
  config.gem 'ambethia-recaptcha', :lib => 'recaptcha/rails', :source => 'http://gems.github.com'
  config.gem 'cap-recipes', :lib => false, :source => 'http://gemcutter.org'
  
  config.gem 'rubyist-aasm', :lib => 'aasm', :version => '>= 2.1.1'
  
  # config.gem 'rspec'
  # config.gem 'rspec-rails'
  # config.gem 'factory_girl'
end



Haml::Template::options[:ugly] = true

ActionView::Base.field_error_proc = Proc.new {|html_tag, instance| "<span class=\"fieldWithErrors\">#{html_tag}</span>"}
ActiveRecord::Base.include_root_in_json = false
