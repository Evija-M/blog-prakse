# frozen_string_literal: true

class Article < ApplicationRecord
  acts_as_paranoid
  ARCHIVED = 'archived'
  scope :non_archived, -> { where.not(status: ARCHIVED) }
  scope :older_than_week, -> { where('updated_at < ?', Time.now - 1.week) }

  include Visible
  has_many :comments, dependent: :destroy
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 5 }
end
