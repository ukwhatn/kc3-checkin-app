class AuthMailer < ApplicationMailer
  def send_auth(email, token, is_admin = false)
    @token = token
    @is_admin = is_admin
    mail to: email, subject: is_admin ? "【KC3】管理者ログイン認証" : "【KC3】ログイン認証"
  end
end
