# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    super
    @user = user
    @comment = comment
  end

  def destroy?
    if user
      comment.user_id == user.id
    else
      false
    end
  end
end
