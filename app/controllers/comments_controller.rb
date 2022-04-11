class CommentsController < ApplicationController
  def show
    @comments = CommentBlueprint.render(Comment.where(recipe_id: params[:id]).order("total_points, created_at desc"))
    render json: { comments: @comments }
  end

  def create
    @comment = Comment.new(
      user_id: session[:user_id], 
      recipe_id: comment_params[:recipe_id],
      content: comment_params[:content]
    )
    if @comment.save
      render json: { status: 200, message: "Comment created"}
    else
      render json: { status: 500, message: @comment.errors.full_messages }
    end
  end

  def update
    @comment = Comment.find_by_id(params[:id])
    return render json: { status: 401 } unless session[:user_id] == @comment.user_id
    return render json: { status: 500 } unless @comment.recipe_id

    if @comment.update(content: comment_params[:content])
      render json: { status: 200, comment: @comment }
    end
  end

  def destroy
    @comment = Comment.find_by_id(params[:id])
    if @comment
      return render json: { status: 401 } unless session[:user_id] == @comment.user_id
      if @comment.destroy!
        render json: { status: 200 }
      end
    else
      return render json: { status: 404, message: "Comment not found!"}
    end 
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :id, :recipe_id, :comment => {})
    end
end