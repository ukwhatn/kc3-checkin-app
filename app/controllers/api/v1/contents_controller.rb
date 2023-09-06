class Api::V1::ContentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_api_key

  def index
    timetable = Timetable.find(params[:timetable_id])
    contents = timetable.contents.pluck(:id, :name, :introduction_url)
    render json: contents
  end
end
