class ListsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @user = User.find(params[:user_id])
    @lists = @user.lists.viewable_by(current_user)
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(params[:list])
    @list.user = current_user

    if @list.save
      flash[:notice] = "List created successfully."
      redirect_to user_lists_path(current_user)
    else
      flash[:alert] = "Failed to create list."
      render action: "new"
    end
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])

    if current_user == @list.user
      if @list.update_attributes(params[:list])
        redirect_to user_lists_path(current_user), notice: "List title changed."
      else
        redirect_to user_lists_path(current_user), alert: "Failed to change list title."
      end
    else
      redirect_to user_lists_path(current_user), alert: "That is not your list."
    end
  end

  def show
    @list = List.find(params[:id])
    @item = ListItem.new
    @list_owner = @list.user
  end

  def destroy
    @list = List.find(params[:id])
    if current_user == @list.user
      @list.destroy
      redirect_to user_lists_path(current_user), notice: "List successfully deleted."
    else
      redirect_to user_lists_path(current_user), notice: "That is not your list."
    end
  end
end
