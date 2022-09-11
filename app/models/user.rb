class User < ApplicationRecord
  validates :name, presence: true, length: {maximum: 10}
  validates :email, presence: true, length: {maximum: 60}

  OCCUPATION = ['営業','設計','人事','オペレータ','データ管理・操作']
  
  has_many :works, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited, class_name: "Favorite", foreign_key: :favorite_id, dependent: :destroy

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = "guest"
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
