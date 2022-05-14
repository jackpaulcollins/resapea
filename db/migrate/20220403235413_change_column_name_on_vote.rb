# frozen_string_literal: true

class ChangeColumnNameOnVote < ActiveRecord::Migration[5.2]
  def change
    rename_column :votes, :type, :vote_type
  end
end
