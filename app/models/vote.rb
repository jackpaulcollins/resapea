class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :voteable, :polymorphic => true
  validates :user_id, uniqueness: { scope: [:voteable_id, :voteable_type], message: "You can only vote on the same post once" }
  validates :voteable_type, inclusion: { in: [ "Recipe", "Comment"] }
  validates_presence_of :vote_type
  validates :vote_type, inclusion: { in: [ -1, 1 ] }
end
