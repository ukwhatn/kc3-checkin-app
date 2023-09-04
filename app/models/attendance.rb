class Attendance < ApplicationRecord
  # === associations ===
  belongs_to :user
  belongs_to :content
  delegate :timetable, to: :content
  delegate :event, to: :timetable
end
