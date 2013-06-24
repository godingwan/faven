class ListsController < ApplicationController
  before_filter :authenticate_user!

  def index
    # TODO: Change this to @user = User.find(params[:user_id])
    @lists = current_user.lists
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(params[:list])
    @list.user = current_user

    if @list.save
      flash[:notice] = "List created successfully"
      redirect_to user_lists_path(:user_id)
    else
      flash[:alert] = "Please provide a Title for your list"
      render action: "new"
    end
  end

  def show
    @list = List.find(params[:id])
    @item = ListItem.new
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
