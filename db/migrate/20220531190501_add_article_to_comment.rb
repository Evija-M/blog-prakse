# frozen_string_literal: true

class AddArticleToComment < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :article, null: false, foreign_key: true
  end
end
