class CommentsController < ActionController::Base
  def create
    @item = ListItem.find(params[:list_item_id])
    @comment = @item.comments.new(params[:comment])
    @comment.user = current_user

    if @comment.save
      redirect_to list_item_path(@item), notice: "Successfully added comment"
    else
      redirect_to list_item_path(@item), alert: "Did not create comment"
    end
  end
end
