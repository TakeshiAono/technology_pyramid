class Technology < ApplicationRecord
  has_many :links, dependent: :destroy
  belongs_to :work
  has_many :hierarckies, dependent: :destroy
end
