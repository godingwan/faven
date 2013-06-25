class ListItemsController < ApplicationController
  def create
    @list = List.find(params[:list_id])
    @item = ListItem.new(params[:list_item])
    @item.list = @list

    if @item.save
      redirect_to list_path(@list), notice: 'Successfully created new item.'
    else
      redirect_to list_path(@list), alert: "Item title cannot be blank."
    end
  end

  def edit
    @list = List.find(params[:list_id])
    @item = ListItem.find(params[:id])
  end

  def update
    @item = ListItem.find(params[:id])
    if current_user == @item.list.user
      if @item.update_attributes(params[:list_item])
        redirect_to list_path(@item.list_id), notice: "Item updated successfully."
      else
        redirect_to list_path(@item.list_id), alert: "Item edit was unsuccessful."
      end
    else
      redirect_to user_lists_path(current_user), alert: "That is not your list."
    end
  end

  def destroy
    @list = List.find(params[:list_id])
    @item = ListItem.find(params[:id])
    @item.destroy

    redirect_to list_path(@list), notice: "Item deleted successfully."
  end
end
