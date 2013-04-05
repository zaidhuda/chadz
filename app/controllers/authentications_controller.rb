class AuthenticationsController < ApplicationController
  before_filter :authenticate_user!, :only => :index
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.authentications.find_or_create_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else
      mail = omniauth["info"]["email"]
      if omniauth['provider'] == "twitter"
        mail = omniauth["info"]["nickname"]+"@chadz.com"        
        url = omniauth["info"]["url"]
      elsif omniauth['provider'] == 'facebook'
        if omniauth["info"]["urls"]["Website"] == nil
          url = omniauth["info"]["urls"]["Facebook"]
        else
          url = omniauth["info"]["urls"]["Website"]
        end
      end
      name = omniauth["info"]["name"]
      img = omniauth['info']['image']

      user = User.find_by_email(mail)

      if user == nil
        user = User.new(:email => mail, :password => Devise.friendly_token)
        user.create_user_info(:name => name, :url => (url), :avatar => img)
      end

      user.apply_omniauth(omniauth)
      user.skip_confirmation! 
      user.save(:validate => false)
      if user.apply_omniauth(omniauth)
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, user)
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_registration_url
      end
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end
