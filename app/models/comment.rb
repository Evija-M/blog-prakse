# frozen_string_literal: true

class Comment < ApplicationRecord
  include Visible
  belongs_to :article

  validates :commenter, presence: true, length: { maximum: 10, minimum: 2 }
  validates :body, presence: true
end
