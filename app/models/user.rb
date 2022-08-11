class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  OCCUPATION = ['営業','設計','人事','オペレータ','データ管理・操作']
  
  has_many :works
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
