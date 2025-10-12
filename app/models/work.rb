class Work < ApplicationRecord
  has_many :technologies, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, length: { maximum: 10 }
end
