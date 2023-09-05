class Common::HomesController < ApplicationController
  def top
    if @current_admin.present?
      # 管理者ログイン済ならadmin/events#indexへ
      redirect_to admin_events_path
    elsif @current_user.present?
      # 顧客ログイン済ならマイページへ
      redirect_to my_page_path
    else
      # その他はauthへ
      redirect_to auth_path
    end
  end
end
