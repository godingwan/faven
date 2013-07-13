class ListItemsController < ApplicationController
  def show
    @item = ListItem.find(params[:id])
    @comments = @item.comments
    @comment = @item.comments.new
  end

  def create
    @list = List.find(params[:list_id])
    @item = ListItem.new(params[:list_item])
    @item.list = @list

    if @item.save
      redirect_to list_path(@list), notice: 'Successfully created new item.'
    else
      redirect_to list_path(@list), alert: "Failed to create item."
    end
  end

  def edit
    @item = current_user.list_items.find(params[:id])
    @list = @item.list
  end

  def update
    @item = current_user.list_items.find(params[:id])
    if @item.update_attributes(params[:list_item])
      redirect_to list_item_path(@item), notice: "Item updated successfully."
    else
      redirect_to list_path(@item.list_id), alert: "Failed to edit item."
    end
  end

  def destroy
    @item = current_user.list_items.find(params[:id])
    @list = @item.list
    @item.destroy

    redirect_to list_path(@list), notice: "Item deleted successfully."
  end
end
