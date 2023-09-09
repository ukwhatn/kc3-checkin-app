class Admin::UsersController < ApplicationController
  before_action :require_admin_authenticated

  def qr
    puts params[:qr_token]
    user = User.find_by_qr_token(params[:qr_token])
    res = {}

    if user.nil?
      res[:status] = "not_found"
    else
      res[:status] = "found"
      res[:user_name] = user.full_name
    end

    render json: res
  end
end
