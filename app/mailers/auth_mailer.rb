class AuthMailer < ApplicationMailer
  def send_auth(email, token)
    @token = token
    mail to: email, subject: "【KC3】ログイン認証"
  end
end
