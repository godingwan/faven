class ListsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @user = User.find(params[:user_id])
    @lists = @user.lists
  end

  def new
    @list = current_user.lists.new
  end

  def create
    # @list = List.new(params[:list])
    @list = current_user.lists.new(params[:list])
    # @list.user = current_user

    if @list.save
      flash[:notice] = "List created successfully."
      redirect_to user_lists_path(current_user)
    else
      flash[:alert] = "Failed to create list."
      render action: "new"
    end
  end

  def edit
    @list = current_user.lists.find(params[:id])
  end

  def update
    @list = current_user.lists.find(params[:id])

    if @list.update_attributes(params[:list])
      redirect_to user_lists_path(current_user), notice: "List title changed."
    else
      redirect_to user_lists_path(current_user), alert: "Failed to change list title."
    end
  end

  def show
    @list = List.find(params[:id])
    # @item = ListItem.new
    @item = current_user.list_items.new
    @list_owner = @list.user
  end

  def destroy
    # @list = List.find(params[:id])
    @list = current_user.lists.find(params[:id])

    @list.destroy
    redirect_to user_lists_path(current_user), notice: "List successfully deleted."
  end
end
