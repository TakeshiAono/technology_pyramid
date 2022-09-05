class Work < ApplicationRecord
  validates :title, presence: true, length: {maximum: 10 }
  has_many :technologies, dependent: :destroy
  belongs_to :user
end
