class Admin::TimetablesController < ApplicationController
  before_action :require_admin_authenticated

  def create
    @new_timetable = Timetable.new(timetable_params)
    @new_timetable.event_id = params[:event_id]
    if @new_timetable.save
      redirect_to admin_event_path(params[:event_id]), notice: "タイムテーブルを作成しました"
    else
      @event = Event.find(params[:event_id])
      @timetables = @event.timetables.sort_by(&:start_at)
      render "admin/events/show"
    end
  end

  def show
    @event = Event.find(params[:event_id])
    @timetable = Timetable.find(params[:id])
    @new_content = Content.new
  end

  def edit
    @event = Event.find(params[:event_id])
    @timetable = Timetable.find(params[:id])
  end

  def update
    @timetable = Timetable.find(params[:id])
    if @timetable.update(timetable_params)
      redirect_to admin_event_path(params[:event_id]), notice: "タイムテーブルを更新しました"
    else
      @event = Event.find(params[:event_id])
      render :edit
    end
  end

  private

  def timetable_params
    params.require(:timetable).permit(:name, :start_at, :end_at)
  end
end
