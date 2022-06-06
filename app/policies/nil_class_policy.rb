# frozen_string_literal: true

class NilClassPolicy < ApplicationPolicy
  def show?
    false
  end

  def index?
    false
  end

  def edit
    false
  end
end
