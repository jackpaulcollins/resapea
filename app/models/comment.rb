class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  has_many :votes, :as => :voteable, dependent: :delete_all
  accepts_nested_attributes_for :recipe, :user

  def total_points
    self.votes.pluck(:vote_type).sum || 0
  end
end
