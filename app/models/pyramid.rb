class Pyramid < ApplicationRecord
  has_many :link_access_counters
  belongs_to :technology
end
