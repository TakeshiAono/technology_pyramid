class Work < ApplicationRecord
  has_many :technologies
  belongs_to :user
end
