class ApplicationController < ActionController::Base
  before_action :create_current_user
  before_action :create_current_admin

  protected

  def require_not_authenticated
    if @current_user || @current_admin
      redirect_to root_path, alert: "すでにログインしています"
    end
  end

  def require_user_authenticated
    unless @current_user
      redirect_to auth_path, alert: "ログインしてください"
    end
  end

  def require_admin_authenticated
    unless @current_admin
      redirect_to auth_path, alert: "管理者としてログインしてください"
    end
  end

  def find_api_key
    if request.headers["X-Api-Key"].present?
      ApiKey.find_by(key_string: request.headers["X-Api-Key"])
    else
      nil
    end
  end

  def require_api_key
    key = find_api_key
    unless key.present?
      render json: { message: "Invalid token" }, status: :unauthorized
    end
  end

  private

  # rubocop:disable Naming/MemoizedInstanceVariableName
  def create_current_user
    @current_user ||= User.logged_in(session)
  end

  def create_current_admin
    @current_admin ||= Admin.logged_in(session)
  end

  # rubocop:enable Naming/MemoizedInstanceVariableName
end
