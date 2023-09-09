class Admin::AttendancesController < ApplicationController
  before_action :require_admin_authenticated

  def create
    @content = Content.find(params[:attendance][:content_id])
    @user = User.find_by_qr_token(params[:attendance][:qr_token])

    if @user.nil?
      redirect_to admin_event_timetable_content_path(@content.timetable.event, @content.timetable, @content),
                  alert: "ユーザーが見つかりませんでした"
      return
    end

    if @content.nil?
      redirect_to admin_event_timetable_content_path(@content.timetable.event, @content.timetable, @content),
                  alert: "コンテンツが見つかりませんでした"
      return
    end

    if @content.attendances.find_by(user_id: @user.id).present?
      redirect_to admin_event_timetable_content_path(@content.timetable.event, @content.timetable, @content),
                  alert: "既に出席を取っています"
      return
    end

    is_first_attendance_in_event = @content.timetable.event.attendances.find_by(user_id: @user.id).nil?

    @new_attendance = Attendance.new
    @new_attendance.content_id = @content.id
    @new_attendance.user_id = @user.id

    if @new_attendance.save
      notice_prefix = is_first_attendance_in_event ? "【初回】" : ""

      redirect_to admin_event_timetable_content_path(@content.timetable.event, @content.timetable, @content),
                  notice: "#{notice_prefix}#{@user.full_name}さんの出席を登録しました"
    else
      redirect_to admin_event_timetable_content_path(@content.timetable.event, @content.timetable, @content),
                  alert: "#{@user.full_name}さんの出席を取れませんでした"
    end
  end

  def destroy
    @attendance = Attendance.find(params[:id])
    @content = @attendance.content

    if @attendance.present? && @attendance.destroy
      redirect_to admin_event_timetable_content_path(@content.timetable.event, @content.timetable, @content),
                  notice: "出席を取り消しました"
    else
      redirect_to admin_event_timetable_content_path(@content.timetable.event, @content.timetable, @content),
                  alert: "出席を取り消せませんでした"
    end
  end
end
