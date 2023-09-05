class Common::AuthenticationsController < ApplicationController
  def new
    @new_auth = EmailAuth.new
  end

  def create
    email = params[:email_auth][:email]
    token = EmailAuth.create_token(email)
    if token
      AuthMailer.send_auth(email, token, admins_domain?(email)).deliver
      redirect_to auth_sent_path
    else
      @new_auth = EmailAuth.new(email:)
      render :new
    end
  end

  def sent
  end

  def token
    token = params[:token]
    auth = EmailAuth.find_in_valid_token(token)
    puts auth

    # tokenが無効な場合は、エラーを表示して終了
    unless auth
      redirect_to auth_path, alert: "無効なトークンです"
      return
    end

    # token無効化
    auth.invalidate_token

    # ログイン処理
    # kc3.me / nxtend.or.jpドメインの場合は、Adminとしてログイン
    if admins_domain?(auth.email)
      admin = Admin.find_or_create_by!(email: auth.email)
      admin.login(session)
      redirect_to admin_events_path
      return
    end

    # それ以外のドメインの場合は、Userの存在判定
    user = User.find_by(email: auth.email)
    if user
      # Userが存在する場合は、ログイン処理
      user.login(session)
      redirect_to my_page_path
    else
      session[:unsaved_email] = auth.email
      redirect_to user_registration_path
    end
  end

  private

  def admins_domain?(email)
    email.end_with?("@kc3.me", "@nxtend.or.jp")
  end
end
