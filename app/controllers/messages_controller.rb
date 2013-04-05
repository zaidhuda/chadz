class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.json
  include ApplicationHelper
  before_filter :authenticate_user! , :only => :index
  def index
    @user = user
    if @user.messages.blank?
      redirect_to :root
      flash[:warning] = "You have no message."
    else
      @messagebox = @user.messagebox
      @messages = @user.messages.page params[:page]

      respond_to do |format|
        format.html # index.html.erb
        format.js { render 'connection/loadmore' }
      end
    end
  end
  # GET /messages/1
  # GET /messages/1.json
  def show
    @user = user
    @messagebox = Messagebox.find(params[:id])
    @messages = @messagebox.messages.page params[:page]
    respond_to do |format|
      format.html { render :layout => false }
      # format.json { render json: @messages }
    end
  end

  # POST /messages
  # POST /messages.json
  def create
    @user = user
    unless Ban.find_by_user_id_and_messagebox_id(@user.id,params[:message][:messagebox_id])
      @message = Message.new(params[:message])
      @message.user_id = @user.id
      @messagebox = @message.messagebox
      respond_to do |format|
        if @message.save
          # flash[:success] = 'Message sent!'
          format.js
        else
          # flash[:error] = 'Please type in something!'
        end
      end
    end
  end

  def update
    @user = user
    if params[:fav] == 'fav'
      params[:fav] = 1
    else
      params[:fav] =0
    end
    @message = Message.find(params[:id])
    message = @message
    @messagebox = @message.messagebox
    @favflag = MsgFavFlag.find_by_fav_and_user_id_and_message_id(params[:fav],@user.id,params[:id])
    if @favflag.blank?
      MsgFavFlag.create(:fav => params[:fav], :user_id => @user.id, :message_id => params[:id])
    else
      @favflag.destroy
    end
    respond_to do |format|
      format.js
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = Message.find(params[:id])
    if owner?(@message,user)
      @messagebox = @message.messagebox
      deletedmsg = params[:id]
      @message.destroy
      respond_to do |format|
        format.js
      end
    end
  end
end
