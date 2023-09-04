class EmailAuth < ApplicationRecord
  # === validations ===

  validates :token, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: {
    with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
    message: "はメールアドレスの形式で入力してください"
  }
  validates :is_expired, inclusion: { in: [true, false] }

  # === methods ===

  # トークン生成・保存
  def self.create_token(email)
    # トークンを生成
    token = SecureRandom.hex(64)
    # トークンをDBに保存
    EmailAuth.create!(token:, email:, is_expired: false)
    # トークンを返す
    token
  end

  # 期限が切れていないトークンを取得
  def self.find_in_valid_token(token)
    EmailAuth.find_by(token:, is_expired: false, created_at: 15.minutes.ago..Time.now)
  end

  # トークンを無効化
  def invalidate_token
    update!(is_expired: true)
  end

  # トークンが有効かどうか
  def valid_token?
    !is_expired && created_at >= 15.minutes.ago
  end
end
