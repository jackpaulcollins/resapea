class VotesController < ApplicationController
  include VoteConcern
  def create
    resource_type = vote_params[:voteable_type].constantize
    resource = resource_type.find_by_id(vote_params[:voteable_id])
    # If the user is trying to flip their vote destroy the existing vote first
    if maybe_destroy_previous_vote(resource, vote_params[:vote_type])
      # returns true if we destroyed the vote and do not want to create a new one
      render json: { status: 200, message: "vote destroyed"}
      return
    end
    @vote = Vote.new(voteable: resource, user_id: session[:user_id], vote_type: vote_params[:vote_type])
    if @vote.save
      render json: { status: 200, message: "vote cast"}
    else
      render json: { status: 500, message: @vote.errors.full_messages.last }
    end
  end

  def show
    resource_type = vote_params[:voteable_type].constantize
    resource = resource_type.find_by_id(params[:id])
    vote_count = resource.total_points
    vote_data = resource.votes
    user_vote_value = vote_data.where(user_id: @current_user.id).pluck(:vote_type)
    render json: { 
                    status: 200, 
                    vote_count: vote_count, 
                    user_voted_on_resource: vote_data.each.pluck(:user_id).include?(@current_user.id),
                    user_vote_value: user_vote_value[0]
                  }
  end

  private

    def vote_params
      params.require(:resource).permit(:vote_type, :voteable_type, :voteable_id, :resource => {})
    end
end