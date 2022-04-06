module VoteConcern
  extend ActiveSupport::Concern

  def maybe_destroy_previous_vote(resource, vote_type)
    @vote = resource.votes.where(user_id: session[:user_id])
    return false unless @vote.any?
    if @vote.pluck(:vote_type)[0].to_s != vote_type.to_s
      Vote.find_by_id(@vote.pluck(:id)).destroy
      return false
    else
      Vote.find_by_id(@vote.pluck(:id)).destroy
      return true
    end
  end
end
