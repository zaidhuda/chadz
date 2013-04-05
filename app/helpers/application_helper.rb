module ApplicationHelper
	def icon(name, size=1)
    #icon("camera-retro")
    #<i class="icon-camera-retro"></i> 
    
    html = "<i class='icon-#{name}' "
    html += "style='font-size:#{size}em' "
    html += "></i>"
    html.html_safe
  end
  
  def button_icon(text, url, name, size=1.5, *options)
    #button_icon("Camera Retro button", "#","refresh",1)
		#<a class="button refresh" href="#"><i style="font-size:1.5em" class="icon-refresh"></i> Camera Retro button</a>
    class_to_add = "button #{name}"
    options.each { |opt| class_to_add += " #{opt}" } if !options.empty?
    link_to(url, html_options = { :class => class_to_add }) {icon(name, 1.5) + " " + text}
  end
  
  def link_icon(text, url, name, size=1, *options)
    #link_icon("Camera Retro button", "#","refresh",1)
    # <a class="refresh" href="#"><i style="font-size:1.5em" class="icon-refresh"></i> Camera Retro button</a>
    
    class_to_add = "#{name}"
    options.each { |opt| class_to_add += " #{opt}" } if !options.empty?
    link_to(url, html_options = { :class => class_to_add }) {icon(name, size) + " " + text}
  end

  def banned?(u,m) # returns true if messagebox ban user
    !Ban.find_by_user_id_and_messagebox_id(u.id, m.id).blank?
  end

  def ipbanned?(u,m) # returns true if messagebox ban ip
    !Ban.find_by_ip_and_messagebox_id(u.last_sign_in_ip, m.id).blank?
  end

  def owner?(m,u) # returns true if m user is owner
      u == m.user
  end

  def fav?(u,m)
    MsgFavFlag.find_by_fav_and_user_id_and_message_id(true,u.id,m.id)
  end

  def flag?(u,m)
    MsgFavFlag.find_by_fav_and_user_id_and_message_id(false,u.id,m.id)
  end
  
  def broadcast(channel, &block)
    message = {:channel => channel, :data => capture(&block), :ext => {:auth_token => FAYE_TOKEN}}
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

  def user
    if user_signed_in?
      user = current_user
    else
      user = guest_user
    end
    user
  end
end
