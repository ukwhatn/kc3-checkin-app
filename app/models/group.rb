class Group < ApplicationRecord
  # === associations ===
  has_many :users, dependent: :destroy

  # === validations ===
  validates :name, presence: true, uniqueness: true

  # === methods ===
  # 作成・取得
  def self.get(name)
    group = Group.find_by(name:)
    if group.nil?
      group = Group.create(name:)
    end
    return group
  end
end
