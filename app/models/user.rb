class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, presence: true, length: {maximum: 10}
  validates :email, presence: true, length: {maximum: 60}

  OCCUPATION = ['営業','設計','人事','オペレータ','データ管理・操作']
  
  has_many :works, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :favorite_user

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now
    end
  end
end
