# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_paranoid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable
  has_many :comments, dependent: :destroy
  has_many :articles, dependent: :destroy

  ROLES = %w[registred admin].freeze

  def admin?
    role == 'admin'
  end
end
