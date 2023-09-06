class ApiKey < ApplicationRecord
  validates :key_string, presence: true, uniqueness: true

  def self.create_token
    api_key = ApiKey.new(key_string: SecureRandom.hex(32))
    if api_key.save
      api_key
    else
      nil
    end
  end

  def self.find_by_key(key_string)
    ApiKey.find_by(key_string:)
  end
end
