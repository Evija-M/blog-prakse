# frozen_string_literal: true

class ArticlePolicy < ApplicationPolicy
  attr_reader :user, :article

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if @user
        @scope.where(status: 'public').or(@scope.where(user_id: @user.id, status: 'private'))
      else
        @scope.where(status: 'public')
      end
    end
  end

  def initialize(user, article)
    super
    @user = user
    @article = article
  end

  def edit?
    user && @article.deleted_at.nil? ? @article.user_id == user.id : false
  end

  def new?
    user
  end

  def create?
    user
  end

  def destroy?
    @article.user == user
  end

  def show?
    @article.status == 'private' ? user == @article.user : true
  end

  def restore?
    @article.user == user
  end

  def show_user_articles?
    user
  end
end
