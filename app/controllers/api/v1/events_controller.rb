class Api::V1::EventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_api_key

  def index
    events = Event.all.pluck(:id, :name, :start_at, :end_at)
    render json: events
  end
end
