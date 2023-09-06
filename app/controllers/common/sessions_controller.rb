class Common::SessionsController < ApplicationController
  def destroy
    reset_session
    redirect_to root_path, notice: "ログアウトしました"
  end
end
