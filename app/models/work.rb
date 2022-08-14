class Work < ApplicationRecord
  has_many :technologies, dependent: :destroy
  belongs_to :user
end
