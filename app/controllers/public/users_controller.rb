class Public::UsersController < ApplicationController
  before_action :user_logged_in?, only: [:show]

  def new
    @new_user = User.new(email: session[:unsaved_email])
  end

  def confirm
  end

  def show
  end

  private

  def user_logged_in?
    redirect_to root_path unless @current_user
  end
end
