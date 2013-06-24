class ListItemsController < ApplicationController
  def create
    @list = List.find(params[:list_id])
    @item = ListItem.new(params[:list_item])
    @item.list = @list

    if @item.save
      redirect_to list_path(@list), notice: 'Successfully created new item'
    else
      render 'lists#show'
    end
  end

  def destroy
    @list = List.find(params[:list_id])
    @item = ListItem.find(params[:id])
    @item.destroy

    redirect_to list_path(@list), notice: "Item deleted successfully."
  end
end
