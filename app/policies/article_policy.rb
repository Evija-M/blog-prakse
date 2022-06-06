# frozen_string_literal: true

class ArticlePolicy < ApplicationPolicy
  attr_reader :user, :article

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      @scope.where(user_id: @user.id)
    end
  end

  def initialize(user, article)
    super
    @user = user
    @article = article
  end

  def edit?
    if user
      @article.user_id == user.id
    else
      false
    end
  end

  def new?
    user
  end
end
