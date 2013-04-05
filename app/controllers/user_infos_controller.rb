class UserInfosController < ApplicationController
  # GET /user_infos
  # GET /user_infos.json
  def index
    if user_signed_in?
      @user = current_user
    else
      @user = guest_user
    end
    @user_info = @user.user_info

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_infos }
    end
  end

  # GET /user_infos/1/edit
  def edit
    if user_signed_in?
      @user = current_user
    else
      @user = guest_user
    end
    @user_info = @user.user_info
    @user_info.user_urls.build
  end

  # PUT /user_infos/1
  # PUT /user_infos/1.json
  def update
    if user_signed_in?
      @user = current_user
    else
      @user = guest_user
    end
    @user_info = @user.user_info

    respond_to do |format|
      if @user_info.update_attributes(params[:user_info])
        format.html { redirect_to "/profile", notice: 'User info was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_info.errors, status: :unprocessable_entity }
      end
    end
  end
end
