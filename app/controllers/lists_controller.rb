class ListsController < ApplicationController
  before_filter :authenticate_user!

  def index
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
      #TODO: redirect to lists_path
      redirect_to list_path(@list)
    else
      flash[:alert] = "Please provide a Title for your list"
      render action: "new"
    end
  end

  def show
    @list = List.find(params[:id])
    @item = ListItem.new
  end
end
