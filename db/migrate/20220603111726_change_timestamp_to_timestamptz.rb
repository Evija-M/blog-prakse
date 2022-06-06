# frozen_string_literal: true

class ChangeTimestampToTimestamptz < ActiveRecord::Migration[7.0]
  def change
    change_column :articles, :created_at, :timestamptz
  end
end
