# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.with_deleted
    authorize @users
  end

  def show
    @user = authorize User.find(params[:id])
  end

  def restore_user
    @user = User.only_deleted.find(params[:user_id])
    authorize current_user, :index?
    @user.recover(recursive: true)
    redirect_to users_path
  end
end
