# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  attr_reader :user

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      @user.admin? ? @scope.with_deleted : false
    end
  end

  def index?
    user.admin?
  end

  def show?
    user
  end

  def deleted?
    User.only_deleted.find(user.id)
  end

  def restore?
    user.admin?
  end
end
