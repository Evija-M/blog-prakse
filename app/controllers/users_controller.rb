# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def admin?
    @user.role == 'admin'
  end
  helper_method :admin?
end
