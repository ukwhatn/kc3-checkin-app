class Admin::ContentsController < ApplicationController
  before_action :require_admin_authenticated

  def create
    @event = Event.find(params[:event_id])
    @timetable = @event.timetables.find(params[:timetable_id])
    @new_content = Content.new(content_params)
    @new_content.timetable_id = params[:timetable_id]
    if @new_content.save
      redirect_to admin_event_timetable_path(@event, @timetable), notice: "コンテンツを作成しました"
    else
      render "admin/timetables/show"
    end
  end

  def show
    @event = Event.find(params[:event_id])
    @timetable = Timetable.find(params[:timetable_id])
    @content = Content.find(params[:id])
    @attendances = @content.attendances
    @new_attendance = Attendance.new
  end

  def edit
    @event = Event.find(params[:event_id])
    @timetable = Timetable.find(params[:timetable_id])
    @content = Content.find(params[:id])
  end

  def update
    @content = Content.find(params[:id])
    if @content.update(content_params)
      redirect_to admin_event_timetable_path(params[:event_id], params[:timetable_id]), notice: "コンテンツを更新しました"
    else
      @event = Event.find(params[:event_id])
      @timetable = Timetable.find(params[:timetable_id])
      render :edit
    end
  end

  private

  def content_params
    params.require(:content).permit(:name, :introduction_url)
  end
end
