class Api::V1::AttendancesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_api_key

  def index
    content = Content.find(params[:content_id])
    attendances = content.attendances.joins(:user).pluck("users.id")
    render json: attendances
  end
end
