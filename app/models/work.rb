class Work < ApplicationRecord
  validates :title, presence: true, length: {maximum: 20 }
  has_many :technologies, dependent: :destroy
  belongs_to :user
end
