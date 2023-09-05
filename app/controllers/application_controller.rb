class ApplicationController < ActionController::Base
  before_action :current_user
  before_action :current_admin

  private

  def current_user
    @current_user ||= User.logged_in(session)
  end

  def current_admin
    @current_admin ||= Admin.logged_in(session)
  end
end
