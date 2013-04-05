class HomeController < ApplicationController
	def index
    	@user = current_user
		if @user.user_info == nil
			name = @user.email.split('@').first
			if UserInfo.find_by_name(name) != nil
				name = name+"#{rand(999)}"
			end
			@user.create_user_info(:name => name, :user_name => name, :avatar => "http://www.gravatar.com/avatar/"+Digest::MD5.hexdigest(@user.email)+"?d=identicon")
		end
		@messages = @user.messages.limit(5)
		@messagesall = @user.messagebox.messages.limit(5) unless @user.messagebox.blank?
	end
end
