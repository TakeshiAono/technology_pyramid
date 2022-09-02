class Link < ApplicationRecord
  validates :title, presence: true, length: {maximum: 20 }
  belongs_to :technology
end
