# frozen_string_literal: true

class CommentsController < ApplicationController
  def show
    @comments = CommentBlueprint.render(Comment.where(recipe_id: params[:id],
                                                      parent_id: nil).order('total_points desc'))
    render json: { comments: @comments }
  end

  def create
    @comment = Comment.new(
      user_id: session[:user_id],
      recipe_id: comment_params[:recipe_id],
      parent_id: comment_params[:parent_id],
      content: comment_params[:content]
    )
    if @comment.save
      render json: { status: 200, message: 'Comment created' }
    else
      render json: { status: 500, message: @comment.errors.full_messages }
    end
  end

  def update
    @comment = Comment.find_by_id(params[:id])
    return render json: { status: 401 } unless session[:user_id] == @comment.user_id
    return render json: { status: 500 } unless @comment.recipe_id

    render json: { status: 200, comment: @comment } if @comment.update(content: comment_params[:content])
  end

  def destroy
    @comment = Comment.find_by_id(params[:id])
    if @comment
      return render json: { status: 401 } unless session[:user_id] == @comment.user_id

      render json: { status: 200 } if @comment.destroy!
    else
      render json: { status: 404, message: 'Comment not found!' }
    end
  end

  def fetch_comment
    @comment = CommentBlueprint.render(Comment.find_by_id(comment_params[:id]))
    if @comment
      render json: { status: 200, comment: @comment }
    else
      render json: { status: 500, message: @comment.errors.full_messages }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :id, :recipe_id, :parent_id, comment: {})
  end
end
