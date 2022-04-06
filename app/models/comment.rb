class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  has_many :votes, :as => :voteable, dependent: :delete_all
  accepts_nested_attributes_for :recipe, :user
end
