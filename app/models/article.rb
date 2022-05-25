class Article < ApplicationRecord
    include Visible
    has_many :comments, dependent: :destroy
    validates :title, presence: true
    validates :body, presence: true, length: {minimum: 5, message: "is too short"}

end
