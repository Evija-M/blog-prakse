# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  attr_reader :user

  def index?
    user.admin?
  end

  # ??????
  def show?
    user.id = @user.id
  end

  def deleted?
    User.only_deleted.find(user.id)
  end

  def signed_in?
    user
  end
end
