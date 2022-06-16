# frozen_string_literal: true

class ChangeRoleToString < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :role, :string
    change_column_default :users, :role, 'registred'
  end
end
