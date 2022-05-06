class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  has_many :votes, :as => :voteable, dependent: :delete_all
  accepts_nested_attributes_for :recipe, :user
  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy
end
