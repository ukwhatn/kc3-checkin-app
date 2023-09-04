class Group < ApplicationRecord
  # === associations ===
  has_many :users, dependent: :destroy

  # === validations ===
  validates :name, presence: true, uniqueness: true

  # === methods ===
  # 作成・取得
  def self.get(name)
    return Group.find_or_create_by(name:)
  end
end
