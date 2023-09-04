class Content < ApplicationRecord
  # === associations ===
  belongs_to :timetable
  has_many :attendances, dependent: :destroy

  # === validations ===
  validates :name, presence: true, length: { maximum: 50 }
  validates :introduction_url, presence: true, format: /\A#{URI::DEFAULT_PARSER.make_regexp(%w(http https))}\z/
end
