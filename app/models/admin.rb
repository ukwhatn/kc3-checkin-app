class Admin < ApplicationRecord
  # === validations ===
  # kc3.meドメインもしくはnxtend.or.jpドメインのメールアドレスのみ許可
  validates :email, presence: true, uniqueness: true, format: {
    with: /\A[\w+\-.]+@(kc3.me|nxtend.or.jp)\z/i,
    message: "はkc3.meドメインもしくはnxtend.or.jpドメインのメールアドレスのみ許可されています"
  }

  # === methods ===
  # 作成
  def self.create_admin(email)
    return Admin.create(email:)
  end

  # セッションから管理者を取得
  def self.logged_in(session)
    return Admin.find_by(id: session[:admin_id])
  end
end
