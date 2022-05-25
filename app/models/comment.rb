class Comment < ApplicationRecord
  include Visible
  belongs_to :article

  validates :commenter, presence: true, length: {maximum: 10}, length:{minimum: 2}
  validates :body, presence: true
end
