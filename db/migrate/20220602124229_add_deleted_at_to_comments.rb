# frozen_string_literal: true

class AddDeletedAtToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :deleted_at, :datetime
    add_index :comments, :deleted_at
  end
end
