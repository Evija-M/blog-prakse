# frozen_string_literal: true

class ChangeTimestampDatatypeToTimestamptz < ActiveRecord::Migration[7.0]
  def change
    change_column :articles, :updated_at, :timestamptz
    change_column :articles, :deleted_at, :timestamptz
  end
end
