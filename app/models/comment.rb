# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user

  validates :commenter, presence: true, length: { maximum: 10, minimum: 2 }
  validates :body, presence: true
end
