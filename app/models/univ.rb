class Univ < ApplicationRecord
  # === associations ===
  has_many :users, dependent: :destroy

  # === validations ===
  validates :name, presence: true, uniqueness: true

  # === methods ===
  # 作成・取得
  def self.get(name)
    univ = Univ.find_by(name:)
    if univ.nil?
      univ = Univ.create(name:)
    end
    return univ
  end
end
