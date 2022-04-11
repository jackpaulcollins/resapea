class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :voteable, :polymorphic => true
  validates :user_id, uniqueness: { scope: [:voteable_id, :voteable_type], message: "You can only vote on the same post once" }
  validates :voteable_type, inclusion: { in: [ "Recipe", "Comment"] }
  validates_presence_of :vote_type
  validates :vote_type, inclusion: { in: [ -1, 1 ] }
  before_save :update_counter_cache_on_create
  before_destroy :update_counter_cache_on_destroy

  def update_counter_cache_on_create
    self.voteable.total_points = self.voteable.total_points + self.vote_type
    self.voteable.save
  end

  def update_counter_cache_on_destroy
    self.voteable.total_points = self.voteable.total_points + (self.vote_type * -1)
    self.voteable.save
  end
end
