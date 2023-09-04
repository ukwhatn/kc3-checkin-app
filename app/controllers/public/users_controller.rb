class Public::UsersController < ApplicationController
  def new
    @new_user = User.new(email: session[:unsaved_email])
  end

  def confirm
  end

  def show
  end
end
