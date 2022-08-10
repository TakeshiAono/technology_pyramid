class Work < ApplicationRecord
  has_many :pyramids
  belongs_to :user
end
