class MessageboxesController < ApplicationController
  helper_method :current_or_guest_user
  before_filter :authenticate_user!, :except => [:show, :settings, :profile, :userprofile]

  def index
    @messagebox = current_user.messagebox
    @messageboxnew = Messagebox.new
  end

  def customize
    @messagebox = current_user.messagebox
    if @messagebox.blank?
      redirect_to messageboxes_path
      flash[:error] = "Create a messagebox to be customized first!"
    else
      @messagebox_attribute = MessageboxAttribute.find_by_messagebox_id(@messagebox.id)
      @color = Color.find_by_messagebox_attribute_id(@messagebox_attribute.id)
      if @messagebox_attribute.custom_css.blank?
        @messagebox_attribute.custom_css = "/* hide guest gravatar icon --REMOVE THIS LINE TO APPLY--\n.message.guest .avatar{\n  display: none;\n}\n.message.guest .message-inner{\n  margin-left: 0;\n}\n*/ --REMOVE THIS LINE TO APPLY--\n/* align registered user avatars on the right side --REMOVE THIS LINE TO APPLY--\n.message.user .avatar{\n  float: right;\n  right: 7px;\n  margin-left: 10px;\n}\n.message.user .message-inner{\n  margin-left: 0;\n  margin-right: 60px;\n}\n*/--REMOVE THIS LINE TO APPLY--\n/* align avatars on the right side --REMOVE THIS LINE TO APPLY--\n.message .avatar{\n  float: right;\n  right: 7px;\n  margin-left: 10px;\n}\n.message .message-inner{\n  margin-left: 0;\n}\n*/--REMOVE THIS LINE TO APPLY--"
      end
    end
  end

  def savecss
    @color = Color.find(params[:id])
    @color.update_attributes(params[:color])
    @messagebox_attribute = MessageboxAttribute.find(params[:id])
    @messagebox_attribute.update_attributes(params[:messagebox_attribute])
    respond_to do |format|
      format.js { render 'refreshsample' }
    end
  end

  # GET /messageboxes/1
  # GET /messageboxes/1.json
  def show
    if user_signed_in?
      @user = current_user
    else
      @user = guest_user
    end
    @messagebox = Messagebox.find(params[:id])
    @messages = @messagebox.messages.page params[:page]
    @messagebox_attribute = MessageboxAttribute.find_by_messagebox_id(@messagebox.id)
    @color = Color.find_by_messagebox_attribute_id(@messagebox_attribute.id)
    @info = @user.user_info
    respond_to do |format|
      format.html
      format.js { render 'loadmore' }
    end
  end

  def profile
    if user_signed_in?
      @user = current_user
    else
      @user = guest_user
    end
    @user_info = @user.user_info
    3.times { @user_info.user_urls.build }
    respond_to do |format|
      format.js
    end
  end

  def settings
    respond_to do |format|
      format.js
    end
  end

  def userprofile
    @user_info = UserInfo.find_by_name(params[:name])

    # url = @user_info.url
    # if url.split("//").count == 1
    #   @url = url.gsub(url, "//"+url)
    # end
    respond_to do |format|
      format.js
    end
  end

  def ban
    if Messagebox.find_by_id(params[:messagebox]) == current_user.messagebox
      @user = User.find_by_id(params[:user])

      if params[:process] == "ban"
        @ban = Ban.find_or_create_by_user_id_and_messagebox_id(params[:user], params[:messagebox])
        @ban.creator = current_user.id
        @ban.save
      elsif params[:process] == "unban"
        Ban.delete_all(:user_id => params[:user], :messagebox_id => params[:messagebox], :creator => current_user.id)
      elsif params[:process] == "banip"
        @ban = Ban.find_or_create_by_ip_and_messagebox_id(@user.last_sign_in_ip, params[:messagebox])
        @ban.creator = current_user.id
        @ban.save
      elsif params[:process] == "unbanip"
        Ban.delete_all(:ip => @user.last_sign_in_ip, :messagebox_id => params[:messagebox], :creator => current_user.id)
      end
      respond_to do |format|
        format.html { head :no_content }
        format.json { head :no_content }
      end

    else
      redirect_to '/messagebox'
    end
  end

  # POST /messageboxes
  # POST /messageboxes.json
  def create
    if current_user.messagebox.blank?
      @messagebox = Messagebox.create(:name => params[:messagebox][:name])
      @messagebox.user = current_user
      # @messagebox_attribute = MessageboxAttribute.find_or_create_by_messagebox_id(@messagebox.id)
      # @color = Color.find_or_create_by_messagebox_attribute_id(@messagebox_attribute.id)
      @messagebox_attribute = @messagebox.create_messagebox_attribute
      @messagebox_attribute.create_color
      respond_to do |format|
        if @messagebox.save
          format.html { redirect_to :back, notice: 'Messagebox was successfully created.' }
          format.json { render json: @messagebox, status: :created, location: @messagebox }
        end
      end
    else
      redirect_to '/messagebox'
    end
  end

  # DELETE /messageboxes/1
  # DELETE /messageboxes/1.json
  def destroy
    @messagebox = Messagebox.find(params[:id])
    @messagebox.destroy
    flash[:warning] = 'Messagebox was successfully deleted.'

    respond_to do |format|
      format.html { redirect_to messageboxes_url }
      format.json { head :no_content }
    end
  end
end

