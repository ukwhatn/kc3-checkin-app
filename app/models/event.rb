class Event < ApplicationRecord
  # === associations ===
  has_many :timetables, dependent: :destroy
  has_many :contents, through: :timetables
  has_many :attendances, through: :contents

  # === validations ===
  validates :name, presence: true, length: { maximum: 50 }
  validates :start_at, presence: true
  validates :end_at, presence: true
end
