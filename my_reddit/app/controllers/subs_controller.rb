class SubsController < ApplicationController

  before_action :require_login
  
  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    #TODO redirect if not moderator and hide edit button from others
  end

  def update
    @sub = Sub.find(params[:id])
    if current_user.id == @sub.moderator_id && @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      flash[:errors] = "You Are not the Moderator" if current_user.id == @sub.moderator_id
      render :edit
    end
  end

  def index
    #maybe filter logic from query string
    @subs = Sub.all
  end

  def show
    @sub = Sub.find(params[:id])
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
