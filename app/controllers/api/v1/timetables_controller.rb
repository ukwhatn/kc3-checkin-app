class Api::V1::TimetablesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_api_key

  def index
    timetables = Event.find_by(id: params[:event_id]).timetables.pluck(:id, :name, :start_at, :end_at)
    render json: timetables
  end
end
