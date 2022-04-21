class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients, dependent: :delete_all
  has_many :instructions, dependent: :delete_all
  has_many :comments, dependent: :delete_all
  has_many :votes, :as => :voteable, dependent: :delete_all
  accepts_nested_attributes_for :recipe_ingredients, :instructions
  has_one_attached :picture, dependent: :delete
  before_save { self.compatibilities.each { |c| c.downcase! }}
  before_save { self.compatibilities.each { |c| c.to_s }}

  scope :in_query, ->(query_string) { where("lower(name) LIKE ? OR lower(genre) LIKE ?", 
                                            "%#{sanitize_sql_like(query_string.downcase)}%",
                                            "%#{sanitize_sql_like(query_string.downcase)}%"
                                            )}
  scope :filter_by_compatibilities, ->(filters) { where("compatibilities @> ?", '{'"#{filters}"'}') }

  self.per_page = 5
end
