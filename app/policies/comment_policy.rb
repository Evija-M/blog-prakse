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
    @article = Article.with_deleted.where(id: comment.article_id).first
    @comment.user == @user && @article.deleted_at.nil?
  end

  def destroy?
    comment.user == user
  end

  def show?
    user
  end
end
