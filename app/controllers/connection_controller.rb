class ConnectionController < ApplicationController
	before_filter :authenticate_user!, :user_must_have_messagebox
	def index
		@user = current_user
		message_ids = Message.select("MAX(id) AS id").group(:user_id).collect(&:id)
		@messages = Message.order("id DESC").where(:id => message_ids, :messagebox_id => current_user.messagebox.id).page params[:page]
		respond_to do |format|
			format.html
			format.js { render 'loadmore' }
		end
	end

	def poster
		@user = current_user
		@messages = Message.where(:user_id => params[:id], :messagebox_id => current_user.messagebox).page params[:page]
		@user = User.find_by_id(params[:id])
		respond_to do |format|
			format.html
			format.js { render 'loadmore' }
		end
	end

	def destroy
		@messages = Message.delete_all(:user_id => params[:id], :messagebox_id => current_user.messagebox)
		respond_to do |format|
	      format.html { redirect_to :connections }
	      format.json { head :no_content }
	    end
	end
  
	def user_must_have_messagebox
		if current_user.messagebox.blank?
			redirect_to '/messagebox'
			flash[:error] = "Create a messagebox first!"
		end
	end
end
