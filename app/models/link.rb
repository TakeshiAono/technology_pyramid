class Link < ApplicationRecord
  validates :title, presence: true, length: { maximum: 60 }

  belongs_to :technology
  has_many :link_goods, dependent: :destroy
end
