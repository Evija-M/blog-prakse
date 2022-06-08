# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    super
    @user = user
    @comment = comment
  end
  
  def create?
    user
  end

  def restore?
    if user
      comment.user_id == user.id
    else 
      false
    end
  end

  def create?
    user
  end

  def destroy?
    user ? comment.user_id == user.id : false
  end

  def restore?
    user ? comment.user_id == user.id : false
  end
  
end
