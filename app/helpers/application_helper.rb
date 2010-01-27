# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper


  def get_page_title(str='')
    title = []
    title << str unless str.blank?
    title << @title unless str.blank?

    "#{title.join(' - ')}#{!title.blank? ? ' | ' : ''}#{configatron.site_name}"
  end

  # Handle the display of flash messages
  def flash_message?; flash.blank?; end
  def flash_messages
    str = ''
    flash.each_pair do |type, msgs|
      next if msgs.blank?
      msgs = msgs.join('<br />') if msgs.is_a?(Array)
      str << "<div class='flash flash_#{type}'>#{msgs}</div>"
    end
    str
  end

end
