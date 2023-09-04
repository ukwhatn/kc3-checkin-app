class User < ApplicationRecord
  # === associations ===
  belongs_to :univ
  belongs_to :group
  has_many :attendances, dependent: :destroy

  # === validations ===
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :grade, presence: true
  validates :qr_token, presence: true, uniqueness: true

  # === enum ===
  enum :grade, [:b1, :b2, :b3, :b4, :m, :d]

  # === methods ===
  # 作成
  def create_user(email, last_name, first_name, univ_name, group_name, grade)
    # 大学を取得
    univ = Univ.get(univ_name)
    # グループを取得
    group = Group.get(group_name)
    # ユーザーを作成
    User.create(email:, last_name:, first_name:, univ:, group:, grade:, qr_token: SecureRandom.hex(64))
  end

  # Eメールからユーザーを取得
  def self.find_by_email(email)
    User.find_by(email:)
  end

  # QRコードを生成
  def qr_code
    RQRCode::QRCode.new(self.qr_token, size: 4, level: :h).as_svg.html_safe
  end

  # QRトークンからユーザーを取得
  def self.find_by_qr_token(qr_token)
    User.find_by(qr_token:)
  end

  # 出席したことのあるeventをすべて取得
  def attended_events
    self.attendances.map(&:event).uniq
  end

  # セッションからユーザーを取得
  def self.logged_in(session)
    return User.find_by(id: session[:user_id])
  end

  # ログイン
  def login(session)
    session[:user_id] = self.id
  end
end
