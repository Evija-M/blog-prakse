# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    authorize current_user, policy_class: UserPolicy
    @users = policy_scope(User)
  end

  def show
    @user = current_user
    authorize @user, policy_class: UserPolicy
  end

  def restore_user
    @user = User.only_deleted.find(params[:user_id])
    authorize current_user, :restore?, policy_class: UserPolicy
    @user.recover(recursive: true)
    redirect_to users_path
  end
end
