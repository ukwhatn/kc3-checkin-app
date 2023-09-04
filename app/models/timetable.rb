class Timetable < ApplicationRecord
  # === associations ===
  belongs_to :event
  has_many :contents, dependent: :destroy

  # === validations ===
  validates :name, presence: true, length: { maximum: 50 }
  validates :start_at, presence: true
  validates :end_at, presence: true
end
