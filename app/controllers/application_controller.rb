class ApplicationController < ActionController::Base

  protect_from_forgery

  # if user is logged in, return current_user, else return guest_user
  def current_or_guest_user
    if current_user
      if session[:guest_user_id]
        logging_in
        guest_user.destroy
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  # find guest_user object associated with the current session,
  # creating one as needed
  def guest_user
    User.find(session[:guest_user_id] ||= create_guest_user.id)
  end

  private

  # called (once) when the user logs in, insert any code your application needs
  # to hand off from guest_user to current_user.
  def logging_in
    # For example:
    guest_messages = guest_user.messages.all
    guest_messages.each do |message|
      message.user_id = current_user.id
      message.save
    end
  end

  def create_guest_user
    mail = "guest_#{Time.now.strftime("%M%S")}#{SecureRandom.hex(4)}@chadz.com"
    name = mail.split("@").first
    @u = User.new(:email => mail, :guest => true)
    @u.last_sign_in_ip = request.remote_ip
    @u.create_user_info(:name => name, :user_name => name, :avatar => "http://www.gravatar.com/avatar/"+Digest::MD5.hexdigest(mail)+"?d=identicon")
    @u.skip_confirmation!
    @u.save!(:validate => false)
    @u
  end

end


# Finally in order to fix the problem with ajax requests you have to turn off protect_from_forgery for the controller action with the ajax request:

# skip_before_filter :verify_authenticity_token, :only => [:name_of_your_action] 

# Another option is to remove protect_from_forgery from application_controller.rb and put in each of your controllers and use :except on the ajax ones:

# protect_from_forgery :except => :receive_guess

# Last but not least, don't forget to add helper_method :current_or_guest_user to the controller to make the method accessible in views.