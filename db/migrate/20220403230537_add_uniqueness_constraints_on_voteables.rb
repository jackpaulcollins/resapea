# frozen_string_literal: true

class AddUniquenessConstraintsOnVoteables < ActiveRecord::Migration[5.2]
  def change
    add_index :votes, %i[user_id voteable_id voteable_type], unique: true
    add_index :votes, %i[voteable_id voteable_type]
  end
end
