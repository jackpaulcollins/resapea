# frozen_string_literal: true

module VoteConcern
  extend ActiveSupport::Concern

  def maybe_destroy_previous_vote(resource, vote_type)
    @vote = resource.votes.where(user_id: session[:user_id])
    return false unless @vote.any?

    Vote.find_by_id(@vote.pluck(:id)).destroy
    @vote.pluck(:vote_type)[0].to_s == vote_type.to_s
  end
end
