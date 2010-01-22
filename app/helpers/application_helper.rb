# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper


  def get_page_title(str='')
    title = []
    title << str unless str.blank?
    title << @title unless str.blank?

    "#{title.join(' - ')}#{!title.blank? ? ' | ' : ''}#{configatron.site_name}"
  end



end
