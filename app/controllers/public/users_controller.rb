class Public::UsersController < ApplicationController
  before_action :require_user_authenticated, only: [:show]
  before_action :require_not_authenticated, only: [:new, :confirm, :create]
  before_action :valid_email_auth?, only: [:new, :confirm, :create]

  def new
    if session[:new_user]
      @new_user = User.new(session[:new_user])
      session.delete(:new_user)
    else
      @new_user = User.new(email: @email_auth.email)
    end

    @groups = Group.all
  end

  def confirm_via_get
    redirect_to user_registration_path
  end

  def confirm
    @new_user = User.new(user_params)

    @new_user.qr_token = SecureRandom.hex(16)

    if params[:user][:univ_name].present?
      @new_user.univ = Univ.find_or_create_by(name: params[:user][:univ_name])
    end

    if @new_user.valid?
      session[:new_user] = @new_user.attributes
      render :confirm
    else
      @groups = Group.all
      render :new
    end
  end

  def create
    @new_user = User.new(session[:new_user])

    if @new_user.save!
      session.delete(:email_auth_id)
      session.delete(:new_user)
      @new_user.login(session)
      redirect_to root_path, notice: "ユーザー登録が完了しました"
    else
      @groups = Group.all
      render :new
    end
  end

  def show
    @attended_events = @current_user.build_attended_contents
  end

  private

  def user_params
    params.require(:user).permit(:email, :last_name, :first_name, :group_id, :grade, :group_id)
  end

  def valid_email_auth?
    unless session[:email_auth_id]
      session.delete(:email_auth_id)
      redirect_to root_path, alert: "メールアドレスの認証が必要です"
      return
    end

    @email_auth = EmailAuth.find_by(id: session[:email_auth_id])
    unless @email_auth
      session.delete(:email_auth_id)
      redirect_to root_path, alert: "メールアドレスの認証が必要です"
    end

    if @email_auth.updated_at < 30.minutes.ago
      session.delete(:email_auth_id)
      redirect_to root_path, alert: "再度メールアドレスの認証を行ってください"
    end
  end
end
