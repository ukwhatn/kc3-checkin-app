class Admin::EventsController < ApplicationController
  before_action :require_admin_authenticated

  def index
    @events = Event.all
    @new_event = Event.new
  end

  def create
    @new_event = Event.new(event_params)
    if @new_event.save
      redirect_to admin_events_path, notice: "イベントを作成しました"
    else
      @events = Event.all
      render :index
    end
  end

  def show
    @event = Event.find(params[:id])
    @timetables = @event.timetables.sort_by(&:start_at)
    @new_timetable = @event.timetables.build
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to admin_events_path, notice: "イベントを更新しました"
    else
      render :edit
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :start_at, :end_at)
  end
end
